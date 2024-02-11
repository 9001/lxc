FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

# https://www.rarlab.com/rar_add.htm
ENV VER="6.2.12" \
    SHA="261ac3728f917f36a03c7c3c563d7775abdb06b598ab48a299d837e8fc0ca75ad885ec8e292aeb1775e87e775ed274e9e0f033001598229ec96db69d69824ddb"

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
