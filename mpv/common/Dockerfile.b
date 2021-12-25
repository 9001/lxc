RUN printf '%s\n' --enable-libvmaf >> mpv-build/ffmpeg_options \
    && tar -xf vmaf-${VER_VMAF}.tar \
    && mkdir vmaf-${VER_VMAF}/libvmaf/b \
    && cd vmaf-${VER_VMAF}/libvmaf/b \
    && $MESON setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static .. --prefix "/tmp/pe-mpv" --bindir="/tmp/pe-mpv/bin" --libdir="/tmp/pe-mpv/lib" \
    && ninja \
    && ninja install
