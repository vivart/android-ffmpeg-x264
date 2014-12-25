#!/bin/bash
pushd `dirname $0`
. settings.sh
pushd ffmpeg
make install
popd; popd
