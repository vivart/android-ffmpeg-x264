#!/bin/bash
pushd `dirname $0`
. settings.sh

pushd x264

./configure \
--prefix=../out/$ARCH \
--enable-pic \
--host=$CROSS_HOST \
--cross-prefix=$CROSS_PREFIX \
--sysroot=$SYSROOT

popd;popd
