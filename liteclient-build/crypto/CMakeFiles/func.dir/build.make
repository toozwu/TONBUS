# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.15.0/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.15.0/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/alexzhang/Documents/TON/official/lite-client

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/alexzhang/Documents/TON/official/liteclient-build

# Include any dependencies generated for this target.
include crypto/CMakeFiles/func.dir/depend.make

# Include the progress variables for this target.
include crypto/CMakeFiles/func.dir/progress.make

# Include the compile flags for this target's objects.
include crypto/CMakeFiles/func.dir/flags.make

crypto/CMakeFiles/func.dir/func/func.cpp.o: crypto/CMakeFiles/func.dir/flags.make
crypto/CMakeFiles/func.dir/func/func.cpp.o: /Users/alexzhang/Documents/TON/official/lite-client/crypto/func/func.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/alexzhang/Documents/TON/official/liteclient-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object crypto/CMakeFiles/func.dir/func/func.cpp.o"
	cd /Users/alexzhang/Documents/TON/official/liteclient-build/crypto && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/func.dir/func/func.cpp.o -c /Users/alexzhang/Documents/TON/official/lite-client/crypto/func/func.cpp

crypto/CMakeFiles/func.dir/func/func.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/func.dir/func/func.cpp.i"
	cd /Users/alexzhang/Documents/TON/official/liteclient-build/crypto && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/alexzhang/Documents/TON/official/lite-client/crypto/func/func.cpp > CMakeFiles/func.dir/func/func.cpp.i

crypto/CMakeFiles/func.dir/func/func.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/func.dir/func/func.cpp.s"
	cd /Users/alexzhang/Documents/TON/official/liteclient-build/crypto && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/alexzhang/Documents/TON/official/lite-client/crypto/func/func.cpp -o CMakeFiles/func.dir/func/func.cpp.s

# Object files for target func
func_OBJECTS = \
"CMakeFiles/func.dir/func/func.cpp.o"

# External object files for target func
func_EXTERNAL_OBJECTS =

crypto/func: crypto/CMakeFiles/func.dir/func/func.cpp.o
crypto/func: crypto/CMakeFiles/func.dir/build.make
crypto/func: crypto/libton_crypto.a
crypto/func: tdutils/libtdutils.a
crypto/func: /usr/lib/libcrypto.dylib
crypto/func: /usr/lib/libz.dylib
crypto/func: third-party/crc32c/libcrc32c.a
crypto/func: crypto/CMakeFiles/func.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/alexzhang/Documents/TON/official/liteclient-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable func"
	cd /Users/alexzhang/Documents/TON/official/liteclient-build/crypto && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/func.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
crypto/CMakeFiles/func.dir/build: crypto/func

.PHONY : crypto/CMakeFiles/func.dir/build

crypto/CMakeFiles/func.dir/clean:
	cd /Users/alexzhang/Documents/TON/official/liteclient-build/crypto && $(CMAKE_COMMAND) -P CMakeFiles/func.dir/cmake_clean.cmake
.PHONY : crypto/CMakeFiles/func.dir/clean

crypto/CMakeFiles/func.dir/depend:
	cd /Users/alexzhang/Documents/TON/official/liteclient-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/alexzhang/Documents/TON/official/lite-client /Users/alexzhang/Documents/TON/official/lite-client/crypto /Users/alexzhang/Documents/TON/official/liteclient-build /Users/alexzhang/Documents/TON/official/liteclient-build/crypto /Users/alexzhang/Documents/TON/official/liteclient-build/crypto/CMakeFiles/func.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : crypto/CMakeFiles/func.dir/depend

