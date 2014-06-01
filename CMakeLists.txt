cmake_minimum_required(VERSION 2.8)
project(DeMariaVim NONE)

message(STATUS "Checking submodules are present")
execute_process(
	COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/scripts/check_submodules_present.rb
	RESULT_VARIABLE SUBMODULES_OKAY)

if(NOT(${SUBMODULES_OKAY} EQUAL 0))
	message(FATAL_ERROR "One or more submodules are missing")
else()
	message(STATUS "Submodules seem to be all there")
endif()

add_subdirectory(vim/bundle/youcompleteme/third_party/ycmd/cpp/)

include(ExternalProject)
ExternalProject_Add(commandt
	PREFIX vim/bundle/command-t/ruby/command-t
	SOURCE_DIR vim/bundle/command-t/ruby/command-t
	BINARY_DIR vim/bundle/command-t/ruby/command-t
	CONFIGURE_COMMAND ruby extconf.rb
	BUILD_COMMAND make
	INSTALL_COMMAND "")
