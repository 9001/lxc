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

#https://git.alpinelinux.org/aports/tree/community/imagemagick/APKBUILD?id=03efedb335ff52238185e1307e1a1727bb317598
RUN wget https://imagemagick.org/archive/releases/ImageMagick-7.1.1-13.tar.xz -Oimagemagick.txz \
    && echo "6f37da80abbb0e62959ef65145bff0de7c47e1a203858bf7b17535d7d26e8bbe351ec9b9ead1a679f5e48ecf8ffc339bec92a01cf4f78f03e7c0c288de4dc8e2  imagemagick.txz" | sha512sum -c

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
    && sed -ri 's/ -ltiff/ -lzstd/g;  s/( -lfontconfig.*)( -lxml2)/\1\2 -lexpat -lbrotlidec -lbrotlicommon -lsharpyuv -lwebp/' Makefile

RUN cd ImageMagick* \
    && make -j$(nproc) \
        LDFLAGS="--static" \
    && make install \
    && mkdir /rls \
    && mv /usr/bin/magick /rls
#        --disable-openmp \
#        --disable-opencl \
#        SHELL="ash -x" \
