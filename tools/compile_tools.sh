#!/bin/bash
# 1. Getting SPTK-3.9

echo "compiling SPTK..."
(
    cd SPTK-3.9;
    ./configure --prefix=$PWD/build;
    make;
    make install
)

# 2. Getting WORLD

echo "compiling World..."
(
    cd World;
    make
    cd examples/analysis_synthesis;
    make
)

# 3. Getting REAPER

echo "compiling REAPER..."
(
    cd REAPER
    mkdir build   # In the REAPER top-level directory
    cd build
    cmake ..
    make
)

# 4. Copy binaries

SPTK_BIN_DIR=bin/SPTK-3.9
WORLD_BIN_DIR=bin/World
REAPER_BIN_DIR=bin/REAPER

mkdir -p bin
mkdir -p $SPTK_BIN_DIR
mkdir -p $WORLD_BIN_DIR
mkdir -p $REAPER_BIN_DIR

cp SPTK-3.9/build/bin/* $SPTK_BIN_DIR/
cp World/build/analysis $WORLD_BIN_DIR/
cp World/build/synthesis $WORLD_BIN_DIR/
cp REAPER/build/reaper $REAPER_BIN_DIR/

if [[ ! -f ${SPTK_BIN_DIR}/x2x ]]; then
    echo "Error installing SPTK tools"
    exit 1
elif [[ ! -f ${WORLD_BIN_DIR}/analysis ]]; then
    echo "Error installing WORLD tools"
    exit 1
elif [[ ! -f ${REAPER_BIN_DIR}/reaper ]]; then
    echo "Error installing REAPER tools"
    exit 1
else
    echo "All tools successfully compiled!!"
fi
