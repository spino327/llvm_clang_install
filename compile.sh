#!/bin/bash

if [ -z "$1" ]; then
    echo "USAGE: compile.sh <phase> <dry_run>. It can be cmake, ninja_build, ninja_install"
    exit -1
fi

phase=$1
dry_run=""

TARGET_SRC=${HOME}/local/llvm
TARGET_BUILD=$TARGET_SRC-build
TARGET_INSTALL=$TARGET_SRC-install

if [ "$#" -ge "2" ]; then
    dry_run="-n"
fi

echo Changing folders to $TARGET_BUILD...
cd $TARGET_BUILD
echo We\'re at $PWD

if [ "$phase" == "cmake" ]; then
	cmake $TARGET_SRC -G "Eclipse CDT4 - Ninja" -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=$TARGET_INSTALL
fi

if [ "$phase" == "ninja_build" ]; then
	ninja $dry_run
fi

if [ "$phase" == "ninja_install" ]; then
	ninja install $dry_run -v
fi
