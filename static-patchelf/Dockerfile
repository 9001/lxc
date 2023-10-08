FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER=0.18.0 \
    SHA=ff08b24212d90a2d6e5987b181fffaa365efbfe2d4191462dd9d0f6655d78a719df1db0add192764677712e5a37a0efeaafdbaa904021c0d63cf5abfa37ab685

WORKDIR /z/src

RUN wget https://github.com/NixOS/patchelf/releases/download/$VER/patchelf-$VER.tar.gz \
    && sha512sum patchelf-$VER.tar.gz \
    && echo "$SHA  patchelf-$VER.tar.gz" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make

RUN tar -xf "patchelf-$VER.tar.gz" \
    && cd patchelf-$VER \
    && ./configure \
        --prefix=/z/inst \
        CFLAGS=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install

RUN cd /z/inst/bin \
    && rm -f zegrep zfgrep \
    && strip * \
    && mv /z/inst/bin /z/rls \
    && find /z/src/ -type d -mindepth 1 -maxdepth 1 -exec rm -rf {} +
