FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV PIXZ_VER="1.0.7" \
    LARC_VER="3.7.2" \
    XZ_VER="5.2.12" \
    PIXZ_SHA="4811da538931620bf05499912c98a501c2c879f3086cd59c4c67b302ded3547a9d246e7fd01ad36512e361c6c4e206e23f2aaf028b25ad44b74b529547a7f5ab" \
    LARC_SHA="1af253203df3014d1fbf3e99ebdc7aa2a3f036c7c2606d0f0550c49973b0fff99ee7262f4a6e20090c0806c40e964731334360daa3b718bde40108183eacc8a1" \
    XZ_SHA="1a67112eb1cfd70352c41a1cbb5e34eacd6da2ae816f5020385772a7698b835d059843c2c30461beb15b7514e95906b2033dac6abf09248b5837270420dfe732"

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
