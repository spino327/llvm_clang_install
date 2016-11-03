#!/bin/bash

if [ -z "$1" ]; then
    echo "USAGE: compile.sh <phase> <dry_run>. It can be cmake, ninja_build, ninja_install"
    exit -1
fi

phase=$1
dry_run=""

TARGET_SRC=${HOME}/local/llvm-out-of-tree/openmp
TARGET_BUILD=$TARGET_SRC/runtime/build
TARGET_INSTALL=${HOME}/local/llvm-oot-install

if [ "$#" -ge "2" ]; then
    dry_run="-n"
fi

mkdir $TARGET_BUILD
echo Changing folders to $TARGET_BUILD...
cd $TARGET_BUILD
echo We\'re at $PWD

if [ "$phase" == "cmake" ]; then
	cmake $TARGET_SRC -G "Eclipse CDT4 - Ninja" -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=$TARGET_INSTALL -DCMAKE_OSX_ARCHITECTURES='i386;x86_64'
fi

if [ "$phase" == "ninja_build" ]; then
	ninja $dry_run
fi

if [ "$phase" == "ninja_install" ]; then
	ninja install $dry_run -v
fi
