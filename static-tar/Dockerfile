FROM docker.io/i386/alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER="1.35" \
    SHA="8b84ed661e6c878fa33eb5c1808d20351e6f40551ac63f96014fb0d0b9c72d5d94d8865d39e36bcb184fd250f84778a3b271bbd8bd2ceb69eece0c3568577510"

RUN wget https://ftp.gnu.org/gnu/tar/tar-$VER.tar.xz \
    && sha512sum tar-$VER.tar.xz \
    && echo "$SHA  tar-$VER.tar.xz" | sha512sum -c \
    && apk add --no-cache gcc patch perl musl-dev make xz

RUN tar -xvf tar-$VER.tar.xz \
    && cd tar-$VER \
    && FORCE_UNSAFE_CONFIGURE=1 \
        ./configure \
        --without-posix-acls \
        --without-xattrs \
        --without-selinux \
        --without-libiconv-prefix \
        --without-libintl-prefix \
        --disable-acl \
        --disable-nls \
        --disable-largefile \
        CFLAGS="-static" \
        LDFLAGS="-static" \
    && make \
        CFLAGS="-static" \
        LDFLAGS="-static"

RUN cd tar-$VER/src \
    && strip tar \
    && mkdir /rls \
    && mv tar /rls

# --disable-largefile to use fstatat rather than fstatat64 for esxi
