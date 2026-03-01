FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="1.8.1" \
    SHA="b09d48dbeaac7b552397b75692ed7833afa72186de80d977fb1b887a14ac66c02f677acdd79f9a2736db1fd738b7ce57a39725e34846bfa21ed3728cd7adc187"

RUN wget https://github.com/stedolan/jq/releases/download/jq-$VER/jq-$VER.tar.gz -O jq.tgz \
    && sha512sum jq.tgz \
    && echo "$SHA  jq.tgz" | sha512sum -c

RUN apk add --no-cache \
        gcc g++ musl-dev make patch linux-headers \
        automake autoconf libtool m4 sed

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
