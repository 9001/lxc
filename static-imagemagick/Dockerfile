FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

WORKDIR /z
RUN apk add --no-cache \
        gcc g++ musl-dev make autoconf libtool automake file \
        zlib-dev libpng-dev libjpeg-turbo-dev zlib-static \
        libtool libwebp-dev chrpath graphviz \
        tiff-dev zstd-static zstd-dev \
        libpng-static \
        libjpeg-turbo-static \
        libwebp-static \
        bzip2-static bzip2-dev \
        freetype-static freetype-dev brotli-static brotli-dev \
        fontconfig-static fontconfig-dev expat-static  \
        lz4-static lz4-dev \
        libxml2-utils libxml2-dev \
        lcms2-dev \
        xz-dev

#https://git.alpinelinux.org/aports/tree/community/imagemagick/APKBUILD?id=03efedb335ff52238185e1307e1a1727bb317598
RUN wget https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-17.tar.gz -Oimagemagick.tgz \
    && echo "0b9950e19bea33841beacfc4a0e484f39005f048b66bd81aad14de678ecd4a62fb5cee029cf834324c0b7cfe41699ede263d4d4af3a30c0fbbbbcd129336c3e1  imagemagick.tgz" | sha512sum -c

RUN tar -xf imagemagick.tgz \
    && cd ImageMagick* \
    && ./configure --help \
    && ./configure \
        --prefix=/usr \
        --datadir=/usr/share \
        --enable-shared=no \
        --enable-static=yes \
        --without-magick-plus-plus \
        --with-threads \
        --with-tiff \
        --with-png \
        --with-webp \
        --with-modules \
        --with-rsvg \
        --with-freetype \
        --with-fontconfig \
        --with-xml \
        --with-lcms \
        --with-gslib=no \
        --with-heic=no \
    && sed -ri 's/ -ltiff/ -ltiff -lzstd/g;  s/( -lfontconfig.*)( -lxml2)/\1\2 -luuid -lexpat -lbrotlidec -lbrotlicommon/' Makefile

RUN cd ImageMagick* \
    && make -j$(nproc) \
        LDFLAGS="--static" \
    && make install
#        --disable-openmp \
#        --disable-opencl \
#        SHELL="ash -x" \
