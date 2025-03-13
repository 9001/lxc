FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

# https://www.rarlab.com/rar_add.htm
ENV VER="7.1.5" \
    SHA="378bd29e6c89d7a11891947967f8235db4690155c91af7b6da0ef3dac4ead34fa5818ead997e3068929b2a4f0f26eb29c0febb41ef093a771eea63ab00e0c36d"

RUN apk add --no-cache \
        gcc g++ musl-dev make patch \
        attr-dev util-linux-dev linux-headers

RUN wget https://www.rarlab.com/rar/unrarsrc-$VER.tar.gz -O unrar.tgz \
    && sha512sum unrar.tgz \
    && echo "$SHA  unrar.tgz" | sha512sum -c

RUN tar -xvf unrar.tgz \
    && cd unrar \
    && make LDFLAGS="-static" -j$(nproc)

RUN mkdir /rls \
    && mv /z/unrar/unrar /rls/ \
    && for f in /rls/*; do strip $f; done
