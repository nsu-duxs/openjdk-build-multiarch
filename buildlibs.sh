#!/bin/bash
set -e
. setdevkitpath.sh

echo "Building Freetype"

if [ "$BUILD_IOS" == "1" ]; then
  EXTRA_ARGS= \
    'CFLAGS=-arch arm64 -pipe -std=c99 -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=8.0 -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libxml2/ -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/' \
    AR=/usr/bin/ar \
    'LDFLAGS=-arch arm64 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -miphoneos-version-min=8.0'
else
  export PATH=$TOOLCHAIN/bin:$PATH
fi

cd freetype-$BUILD_FREETYPE_VERSION
./configure \
	--host=$TARGET \
	--prefix=`pwd`/build_android-${TARGET_SHORT} \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no $EXTRA_ARGS || \
error_code=$?
if [ "$error_code" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
make install

