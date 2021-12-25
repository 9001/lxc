FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="1.6" \
    SHA="5da71f53c325257f1f546a2520fe47828b495c953270df25ea0e37741463fdda72f0ba4d5b05b25114ec30f27a559344c2b024bacabf610759f4e3e9efadb480"

RUN apk add --no-cache \
        gcc g++ musl-dev make patch linux-headers \
        automake autoconf libtool m4

RUN wget https://github.com/stedolan/jq/releases/download/jq-$VER/jq-$VER.tar.gz -O jq.tgz \
    && echo "$SHA  jq.tgz" | sha512sum -c

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
