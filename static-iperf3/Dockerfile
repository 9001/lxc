FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="3.18" \
    SHA="468bbb040e8dc43c664854c823b7d79d9836da774a53f080fdd2258c836874247ca1f876dff490021e0ad3d38a00f972ffeea10eb149fb1fc75bf18e8fd9e974"

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
