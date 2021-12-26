#!/bin/bash

pushd "`dirname "$0"`"
rootdir=`pwd`
tmpdir=/tmp/libsundaowen_curl_with_openssl
target=macos_x86_64
prefix=$tmpdir/$target
version=`cat version.txt`
rm -rf "$tmpdir/$version"
mkdir -p "$tmpdir/$version"
cp -rf "../$version/"* "$tmpdir/$version"
pushd "$tmpdir/$version"
rm -rf build
mkdir build
cd build
cmake -DBUILD64=ON -C "$rootdir/CMakeLists.txt" -DBUILD_CURL_EXE=OFF -DBUILD_SHARED_LIBS=OFF -DOPENSSL_INCLUDE_DIR="$rootdir/../openssl/include/$target" -DOPENSSL_CRYPTO_LIBRARY="$rootdir/../openssl/lib/$target/libcrypto.a" -DOPENSSL_SSL_LIBRARY="$rootdir/../openssl/lib/$target/libssl.a" -DCURL_ZLIB=OFF -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX="$prefix" ..
cmake --build . --target install --config Release --clean-first
popd
mkdir -p "../target/include/$target"
cp -rf "$prefix/include/"* "../target/include/$target"
mkdir -p "../target/lib/$target"
cp -f "$prefix/lib/"*.a "../target/lib/$target"
popd
rm -rf "$tmpdir"
