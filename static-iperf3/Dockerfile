FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="3.16" \
    SHA="32c0a35c632ade4185ba495495842fe7a6af62cb8a8691b791ea4b37429b7b9a22baf5e7389a4c41e344fb35149cf64ece6adda2c79cc096c7787f7c2e3421da"

RUN wget https://github.com/esnet/iperf/archive/$VER.tar.gz \
    && sha512sum $VER.tar.gz \
    && echo "$SHA  $VER.tar.gz" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make \
        openssl-dev openssl-libs-static

RUN tar -xvf $VER.tar.gz \
    && cd iperf-$VER \
    && CFLAGS="-flto=auto" ./configure \
        --prefix=/z/b \
        --enable-shared=no \
        --enable-static=yes \
        --enable-static-bin \
    && make -j$(nproc) install

RUN cd iperf-$VER/src \
    && strip iperf3 \
    && mkdir /rls \
    && mv iperf3 /rls
