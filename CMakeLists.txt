cmake_minimum_required(VERSION 4.1)

project(chromium-bsu
    VERSION 0.9.16.1
    DESCRIPTION "Chromium B.S.U. is a fast paced, arcade-style, top-scrolling space shooter."
    HOMEPAGE_URL https://sourceforge.net/projects/chromium-bsu/
    LANGUAGES CXX
)

# if using valgrind, set BUILD_WITH_ASAN to OFF
option(BUILD_WITH_ASAN "Build with ASAN" ON)

find_package(OpenGL REQUIRED)

find_package(SDL2 CONFIG REQUIRED)
find_package(SDL2_image CONFIG REQUIRED)
find_package(SDL2_mixer CONFIG REQUIRED)

set(target chromium-bsu)
add_executable(${target})
target_compile_definitions(${target} PRIVATE
    -DHAVE_CONFIG_H
    -D_REENTRANT 
    -D_DEFAULT_SOURCE
    -D_XOPEN_SOURCE=600  
    -DPACKAGE="chromium-bsu"
    -DLOCALEDIR="/workspaces/chromium-bsu/install/share/locale" 
    -DPKGDATADIR="/workspaces/chromium-bsu/install/share/chromium-bsu" 
)
target_include_directories(${target} PRIVATE
    ${CMAKE_SOURCE_DIR}/include
)
if(BUILD_WITH_ASAN)
    target_compile_options(${target} PRIVATE -fsanitize=address)
    target_link_options(${target} PRIVATE -fsanitize=address)
endif()
target_link_libraries(${target}
    PRIVATE
    $<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
    $<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>
)
target_link_libraries(${target} PRIVATE $<IF:$<TARGET_EXISTS:SDL2_image::SDL2_image>,SDL2_image::SDL2_image,SDL2_image::SDL2_image-static>)
target_link_libraries(${target} PRIVATE $<IF:$<TARGET_EXISTS:SDL2_mixer::SDL2_mixer>,SDL2_mixer::SDL2_mixer,SDL2_mixer::SDL2_mixer-static>)
target_link_libraries(${target} PRIVATE OpenGL::GL OpenGL::GLU)
target_link_libraries(${target} PRIVATE ftgl)

add_subdirectory(src)

# valgrind target

add_custom_target(valgrind
    COMMAND valgrind
        --leak-check=full
        --show-leak-kinds=all
        --track-origins=yes
        -s --suppressions=${CMAKE_SOURCE_DIR}/chromium-bsu.valgrind.supp
        --gen-suppressions=all
        --log-file=${CMAKE_SOURCE_DIR}/dev/valgrind/logs/memcheck.log
        $<TARGET_FILE:${target}>
    DEPENDS ${target}
    WORKING_DIRECTORY $<TARGET_FILE_DIR:${target}>
    COMMENT "Running chromium-bsu with valgrind"
)
