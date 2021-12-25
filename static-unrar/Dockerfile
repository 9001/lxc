FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="6.1.3" \
    SHA="a5626adbe2ba063082156542f9cf6658f57f917ae1fa565809b19479629c65632033f0acb0800b0083e02e218fcefb4b0a24635a84c3bd8a2919971f2cf89cb3"

COPY makefile.patch /z

RUN apk add --no-cache \
        gcc g++ musl-dev make patch \
        attr-dev util-linux-dev linux-headers

RUN wget https://www.rarlab.com/rar/unrarsrc-$VER.tar.gz -O unrar.tgz \
    && sha512sum unrar.tgz \
    && echo "$SHA  unrar.tgz" | sha512sum -c

RUN tar -xvf unrar.tgz \
    && cd unrar \
    && patch -p1 < /z/makefile.patch \
    && make LDFLAGS="-static" -j$(nproc)

RUN mkdir /rls \
    && mv /z/unrar/unrar /rls/ \
    && for f in /rls/*; do strip $f; done
