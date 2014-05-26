cmake_minimum_required(VERSION 2.8)
project(DeMariaVim NONE)

if(NOT DEFINED VIMDIR)
	SET(VIMDIR $ENV{HOME}/.vim2)
endif()

if(NOT DEFINED VIMRC)
	SET(VIMRC $ENV{HOME}/.vimrc2)
endif()

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

get_filename_component(VIMRC_FILENAME ${VIMRC} NAME)
get_filename_component(VIMRC_FOLDER ${VIMRC} PATH)

message(STATUS "Vim files will be installed to ${VIMDIR}")
message(STATUS "Vimrc will be installed at ${VIMRC_FOLDER}/${VIMRC_FILENAME}")
install(
	FILES ${CMAKE_CURRENT_BINARY_DIR}/vimrc
	DESTINATION ${VIMRC_FOLDER}
	RENAME ${VIMRC_FILENAME})

install(
	DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/vim/
	DESTINATION ${VIMDIR})
