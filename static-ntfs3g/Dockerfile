FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="2022.10.3" \
    SHA="891589483954423b19bef6e8a174fb4311ad92b6397a0db80f77c72b746bf18c2fa12457a571947f92755637a6bc784188920d4f017ae12a420819ab0d74af59"

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
