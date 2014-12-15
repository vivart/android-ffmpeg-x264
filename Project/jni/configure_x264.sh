#!/bin/bash
pushd `dirname $0`
. settings.sh

pushd x264

./configure --cross-prefix=arm-linux-androideabi- \
--enable-pic \
--host=arm-linux \
--cross-prefix=arm-linux-androideabi- \
--sysroot=../toolchain/sysroot/

popd;popd
