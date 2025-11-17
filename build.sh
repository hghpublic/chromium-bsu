#!/bin/bash

cd "$WORKDIR"
clear
set -ex

# clean up

git clean -dxf
git reset --hard HEAD


LOG_DIR="logs"
mkdir -p ${LOG_DIR}

./autogen.sh > ${LOG_DIR}/autogen.log 2>&1
./configure --prefix "$PWD"/install > ${LOG_DIR}/configure.log 2>&1
make -j4 > ${LOG_DIR}/make.log 2>&1
make install > ${LOG_DIR}/make_install.log 2>&1
export PATH=$PWD/install:$PATH