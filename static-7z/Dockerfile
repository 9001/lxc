FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="2408" \
        SHA="889e9aeaa629d6474a609a15066b2fa7b1353fa5e7255e044297591f565b08b16b885d44f4c4a046f2f9da189599ace300cf61fd9ac0e7bc316fb9d96a18a039"

RUN     wget https://www.7-zip.org/a/7z$VER-src.tar.xz -O 7z.txz \
        && sha512sum 7z.txz \
        && echo "$SHA  7z.txz" | sha512sum -c \
        && wget https://git.alpinelinux.org/aports/plain/main/7zip/7-zip-flags.patch \
        && wget https://git.alpinelinux.org/aports/plain/main/7zip/7-zip-musl.patch

RUN     apk add --no-cache \
            gcc g++ musl-dev make patch \
            attr-dev util-linux-dev linux-headers

# https://git.alpinelinux.org/aports/tree/main/7zip/APKBUILD
RUN     tar -xvf 7z.txz \
        && patch -p1 --binary < 7-zip-flags.patch \
        && patch -p1 --binary < 7-zip-musl.patch \
        && cd /z/CPP/7zip/Bundles/Alone2 \
        && mkdir -p b/g \
        && make -f ../../cmpl_gcc.mak LDFLAGS="-static" -j4 \
            DISABLE_RAR=1 \
            CC="${CC:-cc} $CFLAGS $LDFLAGS -D_GNU_SOURCE" \
            CXX="${CXX:-c++} $CXXFLAGS $LDFLAGS -D_GNU_SOURCE" \
        && cd /z/CPP/7zip/Bundles/SFXCon \
        && mkdir -p b/g \
        && make -f ../../cmpl_gcc.mak LDFLAGS="-static" -j4 \
            DISABLE_RAR=1 \
            CC="${CC:-cc} $CFLAGS $LDFLAGS -D_GNU_SOURCE" \
            CXX="${CXX:-c++} $CXXFLAGS $LDFLAGS -D_GNU_SOURCE"

RUN     mkdir /rls \
        && mv CPP/7zip/Bundles/Alone2/b/g/7zz /rls/7z \
        && mv CPP/7zip/Bundles/SFXCon/b/g/7zCon /rls/7zCon.sfx \
        && for f in /rls/*; do strip $f; done
