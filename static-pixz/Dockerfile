FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV PIXZ_VER="1.0.7" \
    LARC_VER="3.8.5" \
    XZ_VER="5.8.2" \
    PIXZ_SHA="4811da538931620bf05499912c98a501c2c879f3086cd59c4c67b302ded3547a9d246e7fd01ad36512e361c6c4e206e23f2aaf028b25ad44b74b529547a7f5ab" \
    LARC_SHA="b050ca8488143503bdec38ffcab7a5010af61f1b93c1207a3fa006d72d643b84aa8c1ab267e890eb39966ccaedd6e18db8fe5b02f2789bbd1b318a3c4cf138f3" \
    XZ_SHA="a14c9d0a118c611d1156cd9a605269c706b976a752c048db7f2eea956e2bf717ce595f46186d951a6c4493e35658e08fa3fe4b256898c6ca08e3695c0ee7b0e5"

RUN wget https://github.com/vasi/pixz/releases/download/v$PIXZ_VER/pixz-$PIXZ_VER.tar.gz \
    && wget https://github.com/tukaani-project/xz/archive/refs/tags/v$XZ_VER/xz-$XZ_VER.tar.gz \
    && wget https://libarchive.org/downloads/libarchive-$LARC_VER.tar.xz \
    && sha512sum *.tar.gz \
    && echo "$PIXZ_SHA  pixz-$PIXZ_VER.tar.gz" | sha512sum -c \
    && echo "$LARC_SHA  libarchive-$LARC_VER.tar.xz" | sha512sum -c \
    && echo "$XZ_SHA  xz-$XZ_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make pkgconf \
        autoconf automake libtool gettext-tiny \
        openssl-dev openssl-libs-static

RUN tar -xvf libarchive-$LARC_VER.tar.xz \
    && cd libarchive-$LARC_VER/ \
    && ./configure --prefix=/z/b --enable-shared=no \
    && make -j$(nproc) LDFLAGS="--static" install

RUN tar -xvf xz-$XZ_VER.tar.gz \
    && cd xz-$XZ_VER/ \
    && autoreconf -fi \
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
