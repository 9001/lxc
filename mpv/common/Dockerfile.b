# needs a LOT of ram, -j8 dies with 12gb
RUN mkdir aom/b \
    && cd aom/b \
    && cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/tmp/pe-mpv" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF .. \
    && make $(awk '!/^MemAvailable:/{next} $2<16*1024*1024{j=4} $2<8*1024*1024{j=2} j{printf "-j%d\n", j;exit 1}' /proc/meminfo) \
    && make install

RUN printf '%s\n' --enable-libvmaf >> mpv-build/ffmpeg_options \
    && tar -xf vmaf-${VER_VMAF}.tar \
    && mkdir vmaf-${VER_VMAF}/libvmaf/b \
    && cd vmaf-${VER_VMAF}/libvmaf/b \
    && $MESON setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static .. --prefix "/tmp/pe-mpv" --bindir="/tmp/pe-mpv/bin" --libdir="/tmp/pe-mpv/lib" \
    && ninja \
    && ninja install
