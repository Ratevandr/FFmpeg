#!/bin/bash
export WORKSPACE="${HOME}/programming/ffmpeg/FFmpeg/"
git -C dav1d pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/dav1d.git && \
mkdir -p dav1d/build && \
cd dav1d/build && \ 
meson setup -Denable_tools=false -Denable_tests=false --default-library=static .. --prefix "${WORKSPACE}/install/build/ffmpeg_build" --libdir="${WORKSPACE}/install/build/ffmpeg_build/lib" && \
ninja && \
ninja install
 
#dav1d replace aom
cd ${WORKSPACE}/ && \
PATH="${WORKSPACE}/install/build/bin:$PATH" PKG_CONFIG_PATH="${WORKSPACE}/install/build/ffmpeg_build/lib/pkgconfig"  CFLAGS="-fvisibility=default" ./configure \
  --prefix="${WORKSPACE}/install/build/ffmpeg_build" \
  --extra-cflags="-I${WORKSPACE}/install/build/ffmpeg_build/include" \
  --extra-ldflags="-L${WORKSPACE}/install/build/ffmpeg_build/lib" \
  --bindir="${WORKSPACE}/install/build/bin/" \
  --shlibdir="${WORKSPACE}/install/build/shlibdir/" \
  --incdir="${WORKSPACE}/install/build/incdir/" \
  --datadir="${WORKSPACE}/install/build/data/" \
  --docdir="${WORKSPACE}/install/build/doc/" \
--disable-debug --disable-programs --disable-doc \
--enable-gpl --enable-version3 --disable-static \
--enable-shared --enable-small --enable-avisynth \
--enable-frei0r --enable-gmp --enable-gnutls --enable-ladspa \
--enable-libass --enable-libcaca --enable-libcdio \
--enable-libcodec2 --enable-libfontconfig --enable-libfreetype \
--enable-libfribidi --enable-libgme --enable-libgsm \
--enable-libmp3lame --enable-libopencore-amrnb \
--enable-libopencore-amrwb --enable-libopencore-amrwb \
--enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse \
--enable-librsvg --enable-librubberband --enable-librtmp --enable-libshine \
--enable-libsnappy --enable-libsoxr --enable-libspeex \
--enable-libtheora --enable-libtwolame --enable-libv4l2 --enable-libvo-amrwbenc \
--enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp \
--disable-libx264 --disable-libx265 --enable-libxvid --enable-libxml2 \
--enable-libzmq --enable-libzvbi --enable-lv2 \
--enable-openal --enable-opencl --enable-opengl \
--enable-libfdk-aac --enable-nonfree \
--extra-ldflags="-L/opt/user/lib/libav/" && \
PATH="${WORKSPACE}/install/build/bin:$PATH" make -j17 && make install 
