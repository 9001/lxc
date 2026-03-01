FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="2501" \
        SHA="5ee146ce993c6d12ad19333dc3545e6c3429212260c22d456390e49ca150e6fcbfc6eae45b5ec61138ae1598d7b4a79d6f2e3ff02929af38039c0ca59823e729"

RUN     wget https://www.7-zip.org/a/7z$VER-src.tar.xz -O 7z.txz \
        && sha512sum 7z.txz \
        && echo "$SHA  7z.txz" | sha512sum -c \
        && wget https://git.alpinelinux.org/aports/plain/main/7zip/7-zip-flags.patch \
        && wget https://git.alpinelinux.org/aports/plain/main/7zip/7-zip-musl.patch

RUN     apk add --no-cache \
            gcc g++ musl-dev make patch \
            attr-dev util-linux-dev linux-headers

# https://github.com/alpinelinux/aports/blob/master/main/7zip/APKBUILD
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
