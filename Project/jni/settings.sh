#!/bin/bash

# set to path of your NDK (or export NDK to environment)

if [[ "x$NDK" == "x" ]]; then
NDK=~/apps/android-ndk-r5c
fi
# i use only a small number of formats - set this to 0 if you want everything.
# changed 0 to the default, so it'll compile shitloads of codecs normally
if [[ "x$minimal_featureset" == "x" ]]; then
minimal_featureset=1
fi

## stop editing

if [[ ! -d $NDK ]]; then
  echo "$NDK is not a directory. Exiting."
  exit 1
fi

current_dir () {
  echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
}

export ARCH=x86
#export ARCH=x86_64
#export ARCH=arm
toolchain_dir=$(current_dir)/toolchain-$ARCH
export PATH=$PATH:$NDK:$toolchain_dir/bin
export SYSROOT=$toolchain_dir/sysroot/

case "$ARCH" in
    arm)
        export CROSS_PREFIX=arm-linux-androideabi-
        export CROSS_HOST=arm-linux
        ;;

    x86)
        export CROSS_PREFIX=i686-linux-android-
        export CROSS_HOST=i686-linux
        ;;

    x86_64)
        export CROSS_PREFIX=x86_64-linux-android-
        export CROSS_HOST=x86_64-linux
        ;;

    *)
        echo "ERROR: Unsupported architecture $ARCH in settings.sh!"
        exit -1
esac

toolchain_gcc=$toolchain_dir/bin/${CROSS_PREFIX}gcc
export LIBGCC_STATIC_LIB=`$toolchain_gcc -print-libgcc-file-name`


echo $PATH

