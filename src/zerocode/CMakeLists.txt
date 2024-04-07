# Copyright © 2024 Bret Brown
# SPDX-License-Identifier: MIT

add_library(zerocode)
add_library(zerocode::zerocode ALIAS zerocode)
# Using the full project version because zerocode does not provide a stable ABI
# between shared library versions
set_property(TARGET zerocode PROPERTY SOVERSION "${PROJECT_VERSION}")

if (CMAKE_BUILD_TYPE OR CMAKE_CONFIGURATION_TYPES)
  # Install a libzerocode.*.a for each explicit build type and/or build configuration.
  # For instance, install libzerocode.debug.a if the build type is debug.
  set_target_properties(zerocode PROPERTIES ARCHIVE_OUTPUT_NAME "zerocode.$<LOWER_CASE:$<CONFIG>>")

  # Same for shed libraries
  set_target_properties(zerocode PROPERTIES LIBRARY_OUTPUT_NAME "zerocode.$<LOWER_CASE:$<CONFIG>>")
endif()
target_sources(zerocode PRIVATE
  zerocode.cxx
)
target_sources(zerocode PUBLIC
  FILE_SET HEADERS
  BASE_DIRS .
  FILES zerocode.hxx
)

# GNUInstallDirs provides default definitions for CMAKE_INSTALL_LIBDIR
# See: https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html
include(GNUInstallDirs)

install(TARGETS zerocode
  EXPORT zerocode
  ARCHIVE
    COMPONENT libzerocode-dev
  FILE_SET HEADERS
    COMPONENT libzerocode-dev
  LIBRARY
    COMPONENT libzerocode
    NAMELINK_COMPONENT libzerocode-dev
)
install(EXPORT zerocode
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/zerocode"
  COMPONENT libzerocode-dev
  NAMESPACE zerocode::
)
# Note: zerocode.pc is very hardcoded to debian-style packaging right now.
# It is highly likely that other packaging systems will need to patch it.
# Something more sophisticated is possible, but keeping this repo simple
# is more important than being that configurable out of the box.
install(FILES zerocode.pc
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
  COMPONENT libzerocode-dev
)
