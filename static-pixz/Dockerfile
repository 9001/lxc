FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV PIXZ_VER="1.0.7" \
    LARC_VER="3.5.2" \
    XZ_VER="5.2.5" \
    PIXZ_SHA="4811da538931620bf05499912c98a501c2c879f3086cd59c4c67b302ded3547a9d246e7fd01ad36512e361c6c4e206e23f2aaf028b25ad44b74b529547a7f5ab" \
    LARC_SHA="2003ec9b24086373451bd7317bdab86d81627f087c14a6f7df1a92e131a216749f9aa352504c3d04dc82b62078b59aeea5aad5543b7e6c1c21fcafa2955d3762" \
    XZ_SHA="7443674247deda2935220fbc4dfc7665e5bb5a260be8ad858c8bd7d7b9f0f868f04ea45e62eb17c0a5e6a2de7c7500ad2d201e2d668c48ca29bd9eea5a73a3ce"

RUN wget https://github.com/vasi/pixz/releases/download/v$PIXZ_VER/pixz-$PIXZ_VER.tar.gz \
    && wget https://www.libarchive.org/downloads/libarchive-$LARC_VER.tar.gz \
    && wget -T 5 https://tukaani.org/xz/xz-$XZ_VER.tar.gz \
    && sha512sum *.tar.gz \
    && echo "$PIXZ_SHA  pixz-$PIXZ_VER.tar.gz" | sha512sum -c \
    && echo "$LARC_SHA  libarchive-$LARC_VER.tar.gz" | sha512sum -c \
    && echo "$XZ_SHA  xz-$XZ_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make pkgconf

RUN tar -xvf libarchive-$LARC_VER.tar.gz \
    && cd libarchive-$LARC_VER/ \
    && ./configure --prefix=/z/b --enable-shared=no \
    && make -j$(nproc) \
    && make install

RUN tar -xvf xz-$XZ_VER.tar.gz \
    && cd xz-$XZ_VER/ \
    && PKG_CONFIG_PATH=/z/b/lib/pkgconfig ./configure --prefix=/z/b --enable-shared=no \
    && make -j$(nproc) \
    && make install

RUN tar -xvf pixz-$PIXZ_VER.tar.gz \
    && cd pixz-$PIXZ_VER/ \
    && ./configure \
        PKG_CONFIG_PATH=/z/b/lib/pkgconfig \
        CFLAGS=-I/z/b/include/ \
        --prefix=/z/b \
        --enable-shared=no \
        --enable-static=yes \
    && make -j$(nproc) \
        LDFLAGS="--static" \
        EXEEXT="-static" \
        install

RUN cd /z/b/bin \
    && strip pixz-static \
    && cp -pv pixz-static /
