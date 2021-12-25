FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

# latest commit in https://github.com/alpinelinux/aports/tree/3.15-stable
ENV APORTS_VER="73f10f2c5075e6e9bdb695a333f1720742888433"

RUN apk add --no-cache \
        alpine-sdk bzip2 curl git perl sudo \
        zstd-static zstd-dev \
        lz4-static lz4-dev \
    && curl -L https://git.alpinelinux.org/aports/snapshot/aports-$APORTS_VER.tar.bz2 | \
        tar -xj --strip-components=1 \
            aports-$APORTS_VER/main/musl \
            aports-$APORTS_VER/main/rsync

COPY musl.patch /main/musl/fgsfds.patch

# https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package
RUN cd main/musl \
    && mv APKBUILD x \
    && awk 'a{a=0;print"\tfgsfds.patch"};b{b=0;print"33c6386fb40123aed8dcf1b702e3925fba2bdb95d24be36f5f15c69c93452f43504972fdaf253a61390846d7ad20d30aafe4349f123476beb6c8314ce768ada0  fgsfds.patch"};/^source="/{a=1};/^sha512sums="/{b=1};1' <x >APKBUILD \
    && adduser -D ed \
    && addgroup ed abuild \
    && echo "ed ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chown -R ed . \
    && sudo -u ed abuild-keygen -ani \
    && sudo -u ed abuild -rK \
    && apk add /home/ed/packages/main/x86_64/musl*.apk \
    && find /main/musl -name fork.c -exec cat '{}' \+ \
    && rm -rf /main/musl/

ENV RSYNC_VER="3.2.3" \
    RSYNC_SHA="48b68491f3ef644dbbbfcaec5ab90a1028593e02d50367ce161fd9d3d0bd0a3628bc57c5e5dec4be3a1d213f784f879b8a8fcdfd789ba0f99837cba16e1ae70e"

RUN wget https://download.samba.org/pub/rsync/src/rsync-$RSYNC_VER.tar.gz \
    && echo "$RSYNC_SHA  rsync-$RSYNC_VER.tar.gz" | sha512sum -c

# esxi compat/perf hacks
COPY rsync.patch /

# https://git.alpinelinux.org/aports/tree/main/rsync/APKBUILD?id=1f2fe44a4d4e27e4bd8d844a8e56550a49d80777
RUN tar -xvf rsync-$RSYNC_VER.tar.gz \
    && cd rsync-$RSYNC_VER \
    && patch -p1 < /main/rsync/Fix-regression-with---delay-updates.patch \
    && patch -p1 < /rsync.patch \
    && ./configure \
        CFLAGS="-static -DINET6" \
        --with-included-popt \
        --with-included-zlib \
        --disable-iconv-open \
        --disable-iconv \
        --disable-ipv6 \
        --disable-xxhash \
        --disable-openssl \
    && make

RUN cd rsync-$RSYNC_VER \
    && strip rsync \
    && cp -pv rsync /rsync-static

# printf '[a]\n\tpath = /\n\tcomment = ye\n' >/etc/rsyncd.conf
# /bin/asdf --daemon --no-detach --address=0.0.0.0
