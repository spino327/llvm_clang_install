#!/bin/bash

if [ -z "$1" ]; then
    echo "USAGE: compile.sh <phase>. It can be cmake, ninja_build, ninja_install"
    exit -1
fi

phase=$1

if [ "$phase" == "cmake" ]; then
	cmake ${HOME}/local/llvm -G "Eclipse CDT4 - Ninja" -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=${HOME}/local/llvm-install
fi

if [ "$phase" == "ninja_build" ]; then
	ninja
fi

if [ "$phase" == "ninja_install" ]; then
	ninja install -v
fi
