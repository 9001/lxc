FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z
RUN apk add --no-cache \
        gcc g++ musl-dev make autoconf automake file \
        libtool chrpath graphviz \
        brotli-dev brotli-static \
        bzip2-dev bzip2-static \
        expat-dev expat-static \
        fontconfig-static fontconfig-dev \
        freetype-dev freetype-static \
        lcms2-dev lcms2-static \
        libpng-dev libpng-static \
        libjpeg-turbo-dev libjpeg-turbo-static \
        libwebp-dev libwebp-static \
        libxml2-dev libxml2-static libxml2-utils \
        lz4-dev lz4-static \
        xz-dev xz-static \
        zlib-dev zlib-static \
        zstd-dev zstd-static

        #libjxl-dev libjxl-static \  "libjxl.a: error adding symbols: file format not recognized"

RUN wget https://imagemagick.org/archive/releases/ImageMagick-7.1.1-26.tar.xz -Oimagemagick.txz \
    && echo "55b93b30781b3a5d90e43caf33dd55bdc6b8e2e0ed11fcbee64ba4d2d98a73b41c9cfc7efafb7efca1bca5bcf27d98862d05ab524b09a4047a49f3d8f6a098a7  imagemagick.txz" | sha512sum -c

RUN tar -xf imagemagick.txz \
    && cd ImageMagick* \
    && ./configure --help \
    && ./configure \
        --prefix=/usr \
        --datadir=/usr/share \
        --enable-shared=no \
        --enable-static=yes \
        --without-magick-plus-plus \
        --with-threads \
        --with-png \
        --with-webp \
        --with-modules \
        --with-freetype \
        --with-fontconfig \
        --with-xml \
        --with-lcms \
        --with-tiff=no \
        --with-gslib=no \
        --with-heic=no \
        LIBS='-lwebp -lsharpyuv -lbrotlidec -lbrotlicommon -lexpat'

RUN cd ImageMagick* \
    && make -j$(nproc) \
        LDFLAGS="--static" \
    && make install \
    && mkdir /rls \
    && mv /usr/bin/magick /rls
#        --disable-openmp \
#        --disable-opencl \
#        SHELL="ash -x" \
