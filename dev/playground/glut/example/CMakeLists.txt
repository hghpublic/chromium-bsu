cmake_minimum_required(VERSION 4.1)

project(Test)

# glpng
# https://cmake.org/cmake/help/latest/module/FetchContent.html
include(FetchContent)
FetchContent_Declare(
  glpng
  GIT_REPOSITORY https://repo.or.cz/glpng.git
  GIT_TAG        master
  OVERRIDE_FIND_PACKAGE
)
FetchContent_MakeAvailable(glpng)

find_package(OpenGL REQUIRED)
find_package(GLUT)
find_package(glpng REQUIRED)

message(STATUS "GLPNG_FOUND: ${GLPNG_FOUND}")
message(STATUS "GLPNG_INCLUDE_DIRS: ${GLPNG_INCLUDE_DIRS}")
message(STATUS "GLPNG_LIBRARIES: ${GLPNG_LIBRARIES}")
message(STATUS "GLPNG_INCLUDE_DIR: ${GLPNG_INCLUDE_DIR}")
message(STATUS "GLPNG_LIBRARY: ${GLPNG_LIBRARY}")

set(target Test)
add_executable(${target} Test.c)
target_link_libraries(${target} PRIVATE GLUT)
target_link_libraries(${target} PRIVATE OpenGL::GL)
target_link_libraries(${target} PRIVATE glpng)
target_include_directories(${target} PRIVATE /workspaces/chromium-bsu/playground/glpng/example/build/_deps/glpng-src/include)
# target_include_directories(${target} PRIVATE ${GLPNG_INCLUDE_DIRS})
# target_link_libraries(${target} PRIVATE ${GLPNG_LIBRARIES})
