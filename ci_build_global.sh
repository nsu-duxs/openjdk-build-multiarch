#!/bin/bash
set -e

export JDK_DEBUG_LEVEL=release

if [ "$BUILD_IOS" != "1" ]; then
  sudo apt update
fi
. setdevkitpath.sh

if [ "$BUILD_IOS" != "1" ]; then
  wget -nc -nv -O android-ndk-$NDK_VERSION-linux-x86_64.zip "https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux-x86_64.zip"
  ./extractndk.sh
  ./getlibs.sh
  ./maketoolchain.sh
fi

# Some modifies to NDK to fix

./buildlibs.sh
./clonejdk.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
