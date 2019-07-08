# TON 中文社区——TONBUS 运营

Telegram Open Network（TON） 是 Telegram 的区块链项目。官方通过邮件定向邀请了部分开发者内测。TONBUS 是被邀请的开发者，本库里的文件为官方06.09更新的 Source。

- TON 中文社区 Telegram 讨论组：https://t.me/ton_china     
- TON 中文社区 Telegram 中文 Channel：https://t.me/tonbus
- TON 中文社区 微信讨论组：（加微信：toozwu，备注 TON）
- TON 中文白皮书：https://mp.weixin.qq.com/s/WLlD088acBDfjUM4bCEd0A 译者：[@吴泰_tooz](https://mp.weixin.qq.com/s/WLlD088acBDfjUM4bCEd0A )
- Github：https://github.com/opeakt/TONBUS

## 时间线：

- 2019年10月31日 前上线 TON 主网
- 2019年7月10日，日本 Liquid 交易所进行 IOU/IEO（个人投资者份额转让）；转让价格：3.5美金
- 今天
- 2019年4月轻节点代码开放，邀请内测。
- 2018年1月第二笔投资，1.03USD价格半公开+数字货币投资机构。
- 2017年12月第一笔投资，0.37USD价格，传统机构投资者。

## 以下是原始的 README.md


This archive is a distribution of a preliminary version of the TON Blockchain Lite Client along with the relevant portions of the TON Blockchain Library. It is not necessarily representative of the totality of the TON Blockchain code developed so far; rather it is a simplified stable version, containing only those files that are necessary for compiling the Lite Client, and sometimes outdated versions of these files sufficient for this purpose.

Use this software at your own risk; consult the DISCLAIMER for more information.

The software is licensed under GNU Lesser General Public License version 2 or later; consult LICENSE.LGPL and LGPL.v2 for more information. If you ever use any of these source files to develop your own versions of this or other software, you must attach a comment with the contents of LGPL.v2 to the beginning of each source file taken from this archive.

The software is likely to compile and work properly on most Linux systems. It should work on macOS and even Windows; however, we do not guarantee this for this preliminary version.

BASIC COMPILATION AND INSTALLATION INSTRUCTIONS

1) Download and unpack the newest version of this archive, available at

https://test.ton.org/download

The TON Blockchain Test Network is updated quite often, so we cannot guarantee that older versions of the Lite Client will always work. Backward compatibility is not enforced at this development stage.

2) Install the newest versions of make, cmake (version 3.0.2 or later), OpenSSL (including C header files), and g++ or clang (or another C++14-compatible compiler as appropriate for your operating system).

3) Suppose that you have unpacked this archive to directory ~/lite-client, where ~ is your home directory, and that you have created an empty directory ~/liteclient-build. Then run the following in a terminal on a Linux system:

cd ~/liteclient-build
cmake ~/lite-client
cmake --build . --target test-lite-client

You might also want to build some extra utilities useful for smart-contract development:

cmake --build . --target fift

4) Download the newest configuration file from https://test.ton.org/ton-lite-client-test1.config.json :

wget https://test.ton.org/ton-lite-client-test1.config.json

5) Run the Lite Client:

./test-lite-client -C ton-lite-client-test1.config.json

If everything was installed successfully, the Lite Client will connect to a special server (a full node for the TON Blockchain Test Network #1) and will send some queries to the server.
If you indicate a writeable "database" directory as an extra argument to the client, it will download and save the block and the state corresponding to the newest masterchain block:

./test-lite-client -C ton-lite-client-test1.config.json -D ~/ton-db-dir

Basic help info can be obtained by typing "help" into the Lite Client. Type "quit" or press Ctrl-C to exit.

6) Now you can create new smart contracts, examine the state of existing smart contracts, send external messages to smart contracts and so on. You can also use Fift (if you have compiled it) to compile, execute, and debug your smart contracts locally.

More details on these activities, including step-by-step instructions for creating a simple wallet smart contract (along with its source code), may be found in the HOWTO file included in this archive.

7) Some documentation on the TON Blockchain and TON Virtual Machine may be found at the download page https://test.ton.org/download . Be aware that this documentation may not be completely in sync with the version currently employed by the Test Network, because some minor implementation details are likely to be changed during the final development and testing phases.

```

```
