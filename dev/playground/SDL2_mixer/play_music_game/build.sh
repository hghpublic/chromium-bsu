#!/bin/sh

# git clean -dxf

cmake -S . -B build
cmake --build build
# (cd ./build || exit && make)
