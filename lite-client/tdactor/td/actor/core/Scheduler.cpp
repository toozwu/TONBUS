#include "td/actor/core/Scheduler.h"

#include "td/actor/core/CpuWorker.h"
#include "td/actor/core/IoWorker.h"

namespace td {
namespace actor {
namespace core {
Scheduler::Scheduler(std::shared_ptr<SchedulerGroupInfo> scheduler_group_info, SchedulerId id, size_t cpu_threads_count)
    : scheduler_group_info_(std::move(scheduler_group_info)), cpu_threads_(cpu_threads_count) {
  scheduler_group_info_->active_scheduler_count++;
  info_ = &scheduler_group_info_->schedulers.at(id.value());
  info_->id = id;
  if (cpu_threads_count != 0) {
    info_->cpu_threads_count = cpu_threads_count;
    info_->cpu_queue = std::make_unique<MpmcQueue<SchedulerMessage>>(1024, max_thread_count());
    info_->cpu_queue_waiter = std::make_unique<MpmcWaiter>();
  }
  info_->io_queue = std::make_unique<MpscPollableQueue<SchedulerMessage>>();
  info_->io_queue->init();

  info_->cpu_workers.resize(cpu_threads_count);
  for (auto &worker : info_->cpu_workers) {
    worker = std::make_unique<WorkerInfo>(WorkerInfo::Type::Cpu, true);
  }
  info_->io_worker = std::make_unique<WorkerInfo>(WorkerInfo::Type::Io, !info_->cpu_workers.empty());

  poll_.init();
  io_worker_ = std::make_unique<IoWorker>(*info_->io_queue);

#if TD_PORT_WINDOWS
  if (info_->id.value() == 0) {
    scheduler_group_info_->iocp.init();
  }
#endif
}

Scheduler::~Scheduler() {
  // should stop
  stop();
  do_stop();
}

void Scheduler::start() {
  for (size_t i = 0; i < cpu_threads_.size(); i++) {
    cpu_threads_[i] = td::thread([this, i] {
      this->run_in_context_impl(*this->info_->cpu_workers[i],
                                [this] { CpuWorker(*info_->cpu_queue, *info_->cpu_queue_waiter).run(); });
    });
    cpu_threads_[i].set_name(PSLICE() << "#" << info_->id.value() << ":cpu#" << i);
  }
#if TD_PORT_WINDOWS
  // FIXME: use scheduler_id
  if (info_->id.value() == 0) {
    scheduler_group_info_->iocp_thread = td::thread([this] {
      WorkerInfo info;
      info.type = WorkerInfo::Type::Cpu;
      this->run_in_context_impl(info, [this] { scheduler_group_info_->iocp.loop(); });
    });
  }
#endif
  this->run_in_context([this] { this->io_worker_->start_up(); });
}

bool Scheduler::run(double timeout) {
  bool res;
  run_in_context_impl(*info_->io_worker, [this, timeout, &res] {
    if (SchedulerContext::get()->is_stop_requested()) {
      res = false;
    } else {
      res = io_worker_->run_once(timeout);
    }
    if (!res) {
      if (!is_stopped_) {
        io_worker_->tear_down();
      }
    }
  });
  if (!res) {
    do_stop();
  }
  return res;
}

void Scheduler::do_stop() {
  if (is_stopped_) {
    return;
  }
  // wait other threads to finish
  for (auto &thread : cpu_threads_) {
    thread.join();
  }
  // Can't do anything else, other schedulers may send queries to this one.
  // Must wait till every scheduler is stopped first..
  is_stopped_ = true;

  io_worker_.reset();
  poll_.clear();
  heap_.for_each([](auto &key, auto &node) { ActorInfo::from_heap_node(node)->unpin(); });

  std::unique_lock<std::mutex> lock(scheduler_group_info_->active_scheduler_count_mutex);
  scheduler_group_info_->active_scheduler_count--;
  scheduler_group_info_->active_scheduler_count_condition_variable.notify_all();
}

Scheduler::ContextImpl::ContextImpl(ActorInfoCreator *creator, SchedulerId scheduler_id,
                                    SchedulerGroupInfo *scheduler_group, Poll *poll, KHeap<double> *heap)
    : creator_(creator), scheduler_id_(scheduler_id), scheduler_group_(scheduler_group), poll_(poll), heap_(heap) {
}

SchedulerId Scheduler::ContextImpl::get_scheduler_id() const {
  return scheduler_id_;
}
void Scheduler::ContextImpl::add_to_queue(ActorInfoPtr actor_info_ptr, SchedulerId scheduler_id, bool need_poll) {
  if (!scheduler_id.is_valid()) {
    scheduler_id = get_scheduler_id();
  }
  auto &info = scheduler_group()->schedulers.at(scheduler_id.value());
  if (need_poll || !info.cpu_queue) {
    info.io_queue->writer_put(std::move(actor_info_ptr));
  } else {
    info.cpu_queue->push(std::move(actor_info_ptr), get_thread_id());
    info.cpu_queue_waiter->notify();
  }
}

ActorInfoCreator &Scheduler::ContextImpl::get_actor_info_creator() {
  return *creator_;
}

bool Scheduler::ContextImpl::has_poll() {
  return poll_ != nullptr;
}
Poll &Scheduler::ContextImpl::get_poll() {
  CHECK(has_poll());
  return *poll_;
}

bool Scheduler::ContextImpl::has_heap() {
  return heap_ != nullptr;
}
KHeap<double> &Scheduler::ContextImpl::get_heap() {
  CHECK(has_heap());
  return *heap_;
}

void Scheduler::ContextImpl::set_alarm_timestamp(const ActorInfoPtr &actor_info_ptr) {
  // Ideas for optimization
  // 1. Several cpu actors with separate heaps. They ask io worker to update timeout only when it has been changed
  // 2. Update timeout only when it has increased
  // 3. Use signal-like logic to combile multiple timeout updates into one
  if (!has_heap()) {
    add_to_queue(actor_info_ptr, {}, true);
    return;
  }
  // we are in PollWorker
  CHECK(has_heap());
  auto &heap = get_heap();
  auto *heap_node = actor_info_ptr->as_heap_node();
  auto timestamp = actor_info_ptr->get_alarm_timestamp();
  if (timestamp) {
    if (heap_node->in_heap()) {
      heap.fix(timestamp.at(), heap_node);
    } else {
      actor_info_ptr->pin(actor_info_ptr);
      heap.insert(timestamp.at(), heap_node);
    }
  } else {
    if (heap_node->in_heap()) {
      actor_info_ptr->unpin();
      heap.erase(heap_node);
    }
  }
}

bool Scheduler::ContextImpl::is_stop_requested() {
  return scheduler_group()->is_stop_requested;
}

void Scheduler::ContextImpl::stop() {
  bool expect_false = false;
  // Trying to set close_flag_ to true with CAS
  auto &group = *scheduler_group();
  if (!group.is_stop_requested.compare_exchange_strong(expect_false, true)) {
    return;
  }

  // Notify all workers of all schedulers
  for (auto &scheduler_info : group.schedulers) {
    scheduler_info.io_queue->writer_put({});
    for (size_t i = 0; i < scheduler_info.cpu_threads_count; i++) {
      scheduler_info.cpu_queue->push({}, get_thread_id());
      scheduler_info.cpu_queue_waiter->notify();
    }
  }
}
void Scheduler::close_scheduler_group(SchedulerGroupInfo &group_info) {
  //LOG(DEBUG) << "close scheduler group";
  // Cannot close scheduler group before somebody asked to stop them
  CHECK(group_info.is_stop_requested);
  {
    std::unique_lock<std::mutex> lock(group_info.active_scheduler_count_mutex);
    group_info.active_scheduler_count_condition_variable.wait(lock,
                                                              [&] { return group_info.active_scheduler_count == 0; });
  }

  //FIXME
  //ContextImpl context(&group_info.schedulers[0].io_worker->actor_info_creator, SchedulerId{0}, &group_info, nullptr,
  //                    nullptr);
  //SchedulerContext::Guard guard(&context);

#if TD_PORT_WINDOWS
  detail::Iocp::Guard iocp_guard(&group_info.iocp);
  group_info.iocp.interrupt_loop();
  group_info.iocp_thread.join();
#endif

  // Drain all queues
  int it = 0;
  for (bool queues_are_empty = false; !queues_are_empty;) {
    queues_are_empty = true;
    for (auto &scheduler_info : group_info.schedulers) {
      // Drain io queue
      auto &io_queue = *scheduler_info.io_queue;
      while (true) {
        int n = io_queue.reader_wait_nonblock();
        if (n == 0) {
          break;
        }
        while (n-- > 0) {
          auto message = io_queue.reader_get_unsafe();
          // message's destructor is called
          queues_are_empty = false;
        }
      }

      // Drain cpu queue
      if (scheduler_info.cpu_queue) {
        auto &cpu_queue = *scheduler_info.cpu_queue;
        while (true) {
          SchedulerMessage message;
          if (!cpu_queue.try_pop(message, get_thread_id())) {
            break;
          }
          // message's destructor is called
          queues_are_empty = false;
        }
      }
    }
    if (++it > 100) {
      LOG(FATAL) << "Failed to drain all queues";
    }
  }
  LOG_IF(ERROR, it > 2) << "It took more than one iteration to drain queues";

  // Just to destroy all elements should be ok.
  for (auto &scheduler_info : group_info.schedulers) {
    scheduler_info.io_queue.reset();
    scheduler_info.cpu_queue.reset();

    // Do not destroy worker infos. run_in_context will crash if they are empty
    scheduler_info.io_worker->actor_info_creator.clear();
    for (auto &worker : scheduler_info.cpu_workers) {
      worker->actor_info_creator.clear();
    }
  }
}
}  // namespace core
}  // namespace actor
}  // namespace td
