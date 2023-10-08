FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="1.7" \
    SHA="4f8a6b0401e6c881dcb97d948fe38871062599a43fff667ede21cf185ec9de33e61878f0a6ea12786d0a632eea592ea0ff860520ba02dbb32f2fa2d2b5db7a0a"

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
