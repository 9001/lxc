FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

RUN apk add --no-cache \
        gcc g++ musl-dev make autoconf libtool automake patch \
        bzip2-dev zlib-dev util-linux e2fsprogs-dev \
        e2fsprogs-static bzip2-static zlib-static


WORKDIR /z


# https://sourceforge.net/projects/ext4magic/files/ext4magic-0.3.2.tar.gz
# https://sourceforge.net/projects/ext4magic/files/Patches/workaround.patch
# https://git.archlinux.org/svntogit/community.git/plain/trunk/01-i_dir_acl.patch?h=packages/ext4magic
# https://git.archlinux.org/svntogit/community.git/plain/trunk/02-Fix-undefined-reference-to-makedev.patch?h=packages/ext4magic
# https://git.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/ext4magic

# /usr/lib/gcc/x86_64-alpine-linux-musl/9.2.0/../../../../x86_64-alpine-linux-musl/bin/ld: cannot find -le2p
# /usr/lib/gcc/x86_64-alpine-linux-musl/9.2.0/../../../../x86_64-alpine-linux-musl/bin/ld: cannot find -lz
# /usr/lib/gcc/x86_64-alpine-linux-musl/9.2.0/../../../../x86_64-alpine-linux-musl/bin/ld: cannot find -lbz2
# /usr/lib/gcc/x86_64-alpine-linux-musl/9.2.0/../../../../x86_64-alpine-linux-musl/bin/ld: cannot find -lmagic
# /usr/lib/gcc/x86_64-alpine-linux-musl/9.2.0/../../../../x86_64-alpine-linux-musl/bin/ld: cannot find -lext2fs
# file-dev bzip2-dev zlib-dev util-linux e2fsprogs-dev


#https://git.alpinelinux.org/aports/tree/main/file/APKBUILD
RUN wget https://github.com/file/file/archive/FILE5_41.tar.gz -Ofile.tgz \
    && echo "efa94eec7f33b6d63e6a835987e83300accc2d81b6ea04e7bc031e4224594f96905bb5ffa8b0b3a5143084a8f5659349dffca9c78d9f444c1fd9b723ecb0c973  file.tgz" | sha512sum -c

RUN tar -xf file.tgz \
    && cd file-* \
    && SH_LIBTOOL='/usr/share/build-1/libtool' autoreconf -f -i \
    && ./configure --help \
    && ./configure \
        --prefix=/usr \
        --datadir=/usr/share \
        --enable-shared=no \
        --enable-static=yes \
    && make \
        LDFLAGS="--static" \
    && make install


ADD ./res /z


RUN wget https://sourceforge.net/projects/ext4magic/files/ext4magic-0.3.2.tar.gz \
    && echo "81bc9ba40dc2ea0bfb01bec160a1bbf0bf8a7983241aba34190d3571386f4d7dc63409866737b8d64516a3594eba11c819bbb721a1942c0a675d5675a7bba9a1  ext4magic-0.3.2.tar.gz" | sha512sum -c

RUN tar -xvf ext4magic-0.3.2.tar.gz \
    && cd ext4magic-0.3.2 \
    && patch -p1 < ../workaround.patch \
    && patch -p1 < ../01-i_dir_acl.patch \
    && patch -p1 < ../02-Fix-undefined-reference-to-makedev.patch \
    && patch -p1 < ../03-musl.patch
#    && SH_LIBTOOL='/usr/share/build-1/libtool' autoreconf -f -i


RUN cd ext4magic-0.3.2 \
    && ./configure --help \
    && LIBS="-lz -lbz2 -lcom_err" \
        ./configure \
        --enable-shared=no \
        --enable-static=yes \
    || { cat config.log; false; }


RUN cd ext4magic-0.3.2 \
    && ls -al \
    && sed -ri 's/file_default/fgsfds_file_default/g' src/file_type.c \
    && make LDFLAGS="--static"


RUN cd ext4magic-0.3.2/src \
    && strip ext4magic \
    && mkdir /z/rls \
    && mv ext4magic /z/rls
