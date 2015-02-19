#!/bin/bash
pushd `dirname $0`
. settings.sh

if [[ $minimal_featureset == 1 ]]; then
  echo "Using minimal featureset"
  featureflags="--disable-everything \
--enable-decoder=mjpeg --enable-demuxer=mjpeg --enable-parser=mjpeg \
--enable-demuxer=image2 --enable-muxer=mp4 --enable-encoder=libx264 --enable-libx264 \
--enable-decoder=rawvideo \
--enable-protocol=file \
--enable-hwaccels"
fi

if [[ $DEBUG == 1 ]]; then
  echo "DEBUG = 1"
  DEBUG_FLAG="--disable-stripping"
fi

pushd ffmpeg

./configure $DEBUG_FLAG --enable-cross-compile \
--arch=$ARCH \
--enable-armv5te \
--target-os=linux \
--disable-stripping \
--prefix=../out/$ARCH \
--disable-neon \
--enable-version3 \
--disable-shared \
--enable-static \
--enable-gpl \
--enable-memalign-hack \
--extra-cflags="-fPIC -DANDROID -Wfatal-errors -Wno-deprecated" \
--enable-libx264 \
--enable-muxer=mp4 \
--enable-encoder=libx264 \
--enable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-network \
--enable-filter=buffer \
--enable-filter=buffersink \
--disable-demuxer=v4l \
--disable-demuxer=v4l2 \
--disable-indev=v4l \
--disable-indev=v4l2 \
--sysroot=$SYSROOT \
--cross-prefix=$CROSS_PREFIX \
--extra-cflags="-I../x264 -Ivideokit" \
--extra-libs="$LIBGCC_STATIC_LIB -lc -ldl" \
--extra-ldflags="-L../x264"

popd; popd
