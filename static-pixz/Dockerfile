FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV PIXZ_VER="1.0.7" \
    LARC_VER="3.7.7" \
    XZ_VER="5.6.4" \
    PIXZ_SHA="4811da538931620bf05499912c98a501c2c879f3086cd59c4c67b302ded3547a9d246e7fd01ad36512e361c6c4e206e23f2aaf028b25ad44b74b529547a7f5ab" \
    LARC_SHA="cce6eecfcd33d228bd1b1162a90bad63750adb53ac4edcaed34e2fdc30b6ba211cf1fd25d4b8761373949ceec266478b09bd70ffa4e374803a29e8573d6d149e" \
    XZ_SHA="b966950eb9206e31f284c9dc3bb0a79f2fabbaf515e88c89da53d3da41ddfeebd2fc6d3d3f8fcd150c70caaaefa43dec0bce84aa183e08bf339d1aebbe041751"

RUN wget https://github.com/vasi/pixz/releases/download/v$PIXZ_VER/pixz-$PIXZ_VER.tar.gz \
    && wget https://www.libarchive.org/downloads/libarchive-$LARC_VER.tar.gz \
    && wget -T 5 https://tukaani.org/xz/xz-$XZ_VER.tar.gz \
    && sha512sum *.tar.gz \
    && echo "$PIXZ_SHA  pixz-$PIXZ_VER.tar.gz" | sha512sum -c \
    && echo "$LARC_SHA  libarchive-$LARC_VER.tar.gz" | sha512sum -c \
    && echo "$XZ_SHA  xz-$XZ_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make pkgconf \
        openssl-dev openssl-libs-static

RUN tar -xvf libarchive-$LARC_VER.tar.gz \
    && cd libarchive-$LARC_VER/ \
    && ./configure --prefix=/z/b --enable-shared=no \
    && make -j$(nproc) LDFLAGS="--static" install

RUN tar -xvf xz-$XZ_VER.tar.gz \
    && cd xz-$XZ_VER/ \
    && PKG_CONFIG_PATH=/z/b/lib/pkgconfig ./configure --prefix=/z/b --enable-shared=no \
    && make -j$(nproc) LDFLAGS="--static" install

RUN tar -xvf pixz-$PIXZ_VER.tar.gz \
    && cd pixz-$PIXZ_VER/ \
    && ./configure \
        PKG_CONFIG_PATH=/z/b/lib/pkgconfig \
        CFLAGS=-I/z/b/include/ \
        --prefix=/z/b \
        --enable-shared=no \
        --enable-static=yes \
    && make -j$(nproc) LDFLAGS="--static" install

#    && find -type l -delete \
#    && rm -f xzdiff xzgrep xzless xzmore \
RUN cd /z/b/bin \
    && (strip *; true) \
    && mkdir /rls \
    && mv * /rls
