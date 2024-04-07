add_executable(zerocode.test)
target_sources(zerocode.test PRIVATE zerocode.test.cxx)
target_link_libraries(zerocode.test PRIVATE zerocode::zerocode)

add_test(
  NAME zerocode.test
  COMMAND zerocode.test
)
