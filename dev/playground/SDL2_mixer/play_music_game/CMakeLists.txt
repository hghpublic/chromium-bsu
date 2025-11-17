cmake_minimum_required(VERSION 4.1)

project(play_music_game C)


find_package(SDL2 CONFIG REQUIRED)
find_package(SDL2_mixer CONFIG REQUIRED)

set(target play_music_game)
add_executable(${target} main.c)
# target_compile_options(${target} PRIVATE c_std_23)

target_link_libraries(${target} PRIVATE
    $<IF:$<TARGET_EXISTS:SDL2_mixer::SDL2_mixer>,
    SDL2_mixer::SDL2_mixer,
    SDL2_mixer::SDL2_mixer-static>
)
target_link_libraries(${target} PRIVATE
    $<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
    $<IF:$<TARGET_EXISTS:SDL2::SDL2>,
        SDL2::SDL2,
        SDL2::SDL2-static>
)
