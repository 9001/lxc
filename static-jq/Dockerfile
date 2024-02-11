FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="1.7.1" \
    SHA="464861fb2e0d6934b616f1dc7f8002d7dae727c8c0c07b385b813e7522ba1ada8ead4165e1d99c892e3ea76e238c55a15b718c738805419721920f88f8d8478c"

RUN wget https://github.com/stedolan/jq/releases/download/jq-$VER/jq-$VER.tar.gz -O jq.tgz \
    && sha512sum jq.tgz \
    && echo "$SHA  jq.tgz" | sha512sum -c

RUN apk add --no-cache \
        gcc g++ musl-dev make patch linux-headers \
        automake autoconf libtool m4

RUN tar -xvf jq.tgz \
    && cd jq-$VER \
    && autoreconf -i \
    && ./configure \
        --disable-maintainer-mode \
        --enable-shared=no \
        --enable-all-static \
    && make -j$(nproc) \
        CFLAGS="-static --static" \
        LDFLAGS="-static --static" \
    && make -j1 \
        DESTDIR="/z/b" \
        install

RUN mkdir /rls \
    && mv /z/b/usr/local/bin/jq /rls \
    && for f in /rls/*; do strip $f; done \
    && mv /z/b/usr/local/share/man/*/* /rls
