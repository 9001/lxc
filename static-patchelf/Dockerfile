FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV VER=0.14.3 \
    SHA=e3065ed63faefd550128a06c03fac92ed5fb02243e0a2347b475a4a02e7c9e677a7a9cd530e54b3e34cb7466597dcffa2391f8755022f2c55a071df763b9aeef

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
