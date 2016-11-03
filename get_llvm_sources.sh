#!/bin/bash

VERSION=3.9.0
BASE_URL=http://llvm.org/releases
POSTFIX=.src.tar.xz

echo Downloading llvm-$VERSION sources

FILES=(
llvm
cfe
clang-tools-extra
compiler-rt
openmp
libcxx
libcxxabi
)

for file in ${FILES[@]}; do
    target_file=$file-$VERSION$POSTFIX
    if [ ! -f $target_file ]; then
        #echo curl -O $BASE_URL/$VERSION/$file-$VERSION$POSTFIX
        curl -O $BASE_URL/$VERSION/$target_file
    else
        echo Already downloaded: $target_file
    fi
done

echo untar

for file in ${FILES[@]}; do
    target_file=$file-$VERSION$POSTFIX
    if [ ! -d "$file-$VERSION.src" ]; then
        tar -xf $target_file
    else
        echo Already extracted: $target_file
    fi
done

echo symlink
ln -vsnf ./llvm-$VERSION.src ./llvm 

echo Moving source code to llvm root tree
[ ! -d "llvm/tools/clang" ] && (mv -v cfe-$VERSION.src llvm/tools/clang)
[ ! -d "llvm/tools/clang/tools/extra" ] && (mv -v clang-tools-extra-$VERSION.src llvm/tools/clang/tools/extra)
[ ! -d "llvm/projects/compiler-rt" ] && (mv -v compiler-rt-$VERSION.src llvm/projects/compiler-rt)
[ ! -d "llvm/projects/libcxx" ] && (mv -v libcxx-$VERSION.src llvm/projects/libcxx)
[ ! -d "llvm/projects/libcxxabi" ] && (mv -v libcxxabi-$VERSION.src llvm/projects/libcxxabi)

echo creating llvm-build and llvm-install
mkdir llvm-build
mkdir llvm-install

echo creating llvm-out-of-tree and llvm-oot-install
mkdir llvm-out-of-tree
mkdir llvm-oot-install

echo Moving openmp src to oot
[ ! -d "llvm-out-of-tree/openmp-$VERSION.src" ] && (mv -v openmp-$VERSION.src llvm-out-of-tree/)
echo symlink
cd llvm-out-of-tree
ln -vsnf ./openmp-$VERSION.src ./openmp
