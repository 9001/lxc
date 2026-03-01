FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="3.20" \
    SHA="2a52d27388e2585327f92b9cd33335345706371533f1e8da9aa5fb66d11cca70d8690f12c24bf31d7fa231e41225faa2f93b7b31fd869cbd2f34ab5401e3f5ff"

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
