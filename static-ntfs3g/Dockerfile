FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="2021.8.22" \
    SHA="e0544df78a6c352999e1206d7b5d71c56e39396b7a0936a261d728c2ac9d61c6b95ef297f8529ac2a5146f31c1c9e43066d3e281064d4f5d781a04eba51f536d"

RUN apk add --no-cache \
        gcc g++ musl-dev make patch \
        attr-dev util-linux-dev linux-headers

RUN wget https://tuxera.com/opensource/ntfs-3g_ntfsprogs-$VER.tgz -O ntfs3g.tgz \
    && sha512sum ntfs3g.tgz \
    && echo "$SHA  ntfs3g.tgz" | sha512sum -c

RUN tar -xvf ntfs3g.tgz \
    && cd ntfs-3g_ntfsprogs-$VER \
    && ./configure \
        --enable-really-static \
        --enable-shared=no \
    && make \
        CFLAGS="-static --static" \
        LDFLAGS="-static --static" \
    && make -j1 \
        DESTDIR="/z/b" \
        LDCONFIG=: \
        install

RUN mkdir /rls \
    && cd /z/b \
    && mv bin/* usr/local/*bin/* /rls \
    && cd /rls \
    && find -type l -delete \
    && for f in *; do strip $f; done \
    && ln -s mkntfs mkfs.ntfs

# list Makefile targets:
# make -pRrq : | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($1 !~ "^[#.]") {print $1}}' | egrep -v '^[^[:alnum:]]' | sort | xargs | tr ' ' '\n' | sort 
