FROM i386/alpine:3.15
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

RUN apk add --no-cache \
        gcc g++ make patch bash grep unzip musl-dev gmp-dev \
        openssl-dev openssl-libs-static zlib-dev zlib-static

RUN wget https://github.com/libtom/libtommath/releases/download/v1.2.0/ltm-1.2.0.tar.xz -O ltm.txz \
    && wget https://github.com/libtom/libtomcrypt/releases/download/v1.18.2/crypt-1.18.2.tar.xz -O ltc.txz \
    && wget https://downloads.sourceforge.net/mcrypt/libmcrypt-2.5.8.tar.bz2 -O libmcrypt.tbz2 \
    && wget https://git.alpinelinux.org/aports/plain/community/libmcrypt/fix_enigma.patch \
    && wget https://aluigi.altervista.org/papers/quickbms-src-0.11.0.zip -O quickbms.zip

COPY uname /usr/local/bin/

RUN tar -xvf ltm.txz \
    && cd libtommath-* \
    && make -j$(nproc) \
    && make install

COPY rename-tomcrypt-stuff.sh /z/

RUN tar -xvf ltc.txz \
    && cd libtomcrypt-* \
    && ash /z/rename-tomcrypt-stuff.sh \
    && make -j$(nproc) \
        EXTRALIBS="-lgmp -ltommath" \
        CFLAGS="-DGMP_DESC -DLTM_DESC -DUSE_LTM" \
    && make install

RUN tar -xvf libmcrypt.tbz2 \
    && cd libmcrypt-* \
    && patch -p1 <../fix_enigma.patch \
    && ./configure \
        --prefix=/usr \
        --disable-posix-threads \
        --enable-static=yes \
        --enable-shared=no \
    && make -j$(nproc) \
    && make install

#COPY qbms-nopie.patch /z/

RUN unzip quickbms.zip \
    && cd src \
    && (cd libs/libtomcrypt && ash /z/rename-tomcrypt-stuff.sh) 
    #&& dos2unix libs/glza/GLZAmodel.c \
    #&& dos2unix libs/nintendo_ds/lzss.c \
    #&& patch -p1 <../qbms-nopie.patch \
    #&& rm compression/dict.c.orig

ENV CDEFS="-static -DQUICKBMS64 -ldl -lmcrypt -ltomcrypt -lgmp -ltommath"

RUN cd src \
    && time make -j$(nproc) CDEFS="${CDEFS}" \
    && make install

RUN mkdir /rls \
    && mv /usr/local/bin/quickbms /rls \
    && for f in /rls/*; do strip $f; done
