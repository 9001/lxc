FROM i386/alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV VER="1.34" \
    SHA="5e77c4a7b49983ad7d15238c2bce28be7a8aa437b4b1815fc00abd13096da308b6bba196cc6e3ed79d85e62823d520ae0d8fcda2d93873842cf84dc3369fc902"

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
        LDFLAGS="-static" \
        EXEEXT="-static"

RUN cd tar-$VER \
    && strip src/tar-static \
    && cp -pv src/tar-static /

# --disable-largefile to use fstatat rather than fstatat64 for esxi
