set -e
export PATH=/home/coloryr/Desktop/java8/jdk8u392-b08/bin:$PATH
export TARGET=aarch64-linux-android
export TARGET_JDK=aarch64
export NDK_PREBUILT_ARCH=/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/aarch64-linux-android/bin/strip
. setdevkitpath.sh
export JDK_DEBUG_LEVEL=release
./maketoolchain.sh
#./buildlibs.sh
#./clonejdk.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
