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

# Utility rule file for tdmime_auto.

# Include the progress variables for this target.
include tdutils/generate/CMakeFiles/tdmime_auto.dir/progress.make

tdutils/generate/CMakeFiles/tdmime_auto: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.cpp
tdutils/generate/CMakeFiles/tdmime_auto: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.cpp


/Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.cpp: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/alexzhang/Documents/TON/official/liteclient-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.cpp"
	cd /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate && /usr/bin/gperf -m100 auto/mime_type_to_extension.gperf | grep -v __gnu_inline__ > auto/mime_type_to_extension.cpp

/Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.cpp: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.gperf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/alexzhang/Documents/TON/official/liteclient-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.cpp"
	cd /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate && /usr/bin/gperf -m100 auto/extension_to_mime_type.gperf | grep -v __gnu_inline__ > auto/extension_to_mime_type.cpp

/Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf: tdutils/generate/generate_mime_types_gperf
/Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/mime_types.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/alexzhang/Documents/TON/official/liteclient-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Generating /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf, /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.gperf"
	cd /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate && /Users/alexzhang/Documents/TON/official/liteclient-build/tdutils/generate/generate_mime_types_gperf mime_types.txt /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.gperf

/Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.gperf: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf
	@$(CMAKE_COMMAND) -E touch_nocreate /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.gperf

tdmime_auto: tdutils/generate/CMakeFiles/tdmime_auto
tdmime_auto: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.cpp
tdmime_auto: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.cpp
tdmime_auto: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/mime_type_to_extension.gperf
tdmime_auto: /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate/auto/extension_to_mime_type.gperf
tdmime_auto: tdutils/generate/CMakeFiles/tdmime_auto.dir/build.make

.PHONY : tdmime_auto

# Rule to build all files generated by this target.
tdutils/generate/CMakeFiles/tdmime_auto.dir/build: tdmime_auto

.PHONY : tdutils/generate/CMakeFiles/tdmime_auto.dir/build

tdutils/generate/CMakeFiles/tdmime_auto.dir/clean:
	cd /Users/alexzhang/Documents/TON/official/liteclient-build/tdutils/generate && $(CMAKE_COMMAND) -P CMakeFiles/tdmime_auto.dir/cmake_clean.cmake
.PHONY : tdutils/generate/CMakeFiles/tdmime_auto.dir/clean

tdutils/generate/CMakeFiles/tdmime_auto.dir/depend:
	cd /Users/alexzhang/Documents/TON/official/liteclient-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/alexzhang/Documents/TON/official/lite-client /Users/alexzhang/Documents/TON/official/lite-client/tdutils/generate /Users/alexzhang/Documents/TON/official/liteclient-build /Users/alexzhang/Documents/TON/official/liteclient-build/tdutils/generate /Users/alexzhang/Documents/TON/official/liteclient-build/tdutils/generate/CMakeFiles/tdmime_auto.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tdutils/generate/CMakeFiles/tdmime_auto.dir/depend
