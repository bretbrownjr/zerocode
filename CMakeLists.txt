# Copyright © 2024 Bret Brown
# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.23)
project(zerocode
  VERSION 1.0.0
  DESCRIPTION "A C++ project with no code"
  LANGUAGES CXX
)
include(CTest)

add_subdirectory(src/zerocode)
add_subdirectory(test/zerocode)
