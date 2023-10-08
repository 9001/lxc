FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="2301" \
        SHA="e39f660c023aa65e55388be225b5591fe2a5c9138693f3c9107e2eb4ce97fafde118d3375e01ada99d29de9633f56221b5b3d640c982178884670cd84c8aa986"

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
        && patch -p1 < 7-zip-flags.patch \
        && patch -p1 < 7-zip-musl.patch \
        && cd /z/CPP/7zip/Bundles/Alone2 \
        && mkdir -p b/g \
        && make -f ../../cmpl_gcc.mak LDFLAGS="-static" -j4 \
            CC="${CC:-cc} $CFLAGS $LDFLAGS -D_GNU_SOURCE" \
            CXX="${CXX:-c++} $CXXFLAGS $LDFLAGS -D_GNU_SOURCE" \
        && cd /z/CPP/7zip/Bundles/SFXCon \
        && mkdir -p b/g \
        && make -f ../../cmpl_gcc.mak LDFLAGS="-static" -j4 \
            CC="${CC:-cc} $CFLAGS $LDFLAGS -D_GNU_SOURCE" \
            CXX="${CXX:-c++} $CXXFLAGS $LDFLAGS -D_GNU_SOURCE"

RUN     mkdir /rls \
        && mv CPP/7zip/Bundles/Alone2/b/g/7zz /rls/7z \
        && mv CPP/7zip/Bundles/SFXCon/b/g/7zCon /rls/7zCon.sfx \
        && for f in /rls/*; do strip $f; done
