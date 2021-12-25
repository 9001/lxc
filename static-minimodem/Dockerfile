FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV MM_VER="0.24-1" \
    MM_SHA="4a60a13596adbebc2b0b63579b037b595221f1ba7ede33e0e74d8866ffd786f2a9504e01c9ff06e136af5e1a6f0a43940e7d3650e19a0964bc1fc9ba231b437c" \
    SF_VER="d60deb5d8691997b6bb28d88e3b43f322073d146" \
    SF_SHA="b04a99fad706c3e7f10f729a79d1648ea58b0a064cc784d91fdf4a5cb2ff8d779b62cc95ada83755c6b8de787c3e98025cc6a05db11f81890c657f81236def76"
    #AG_VER="5.18.16" \
    #AG_SHA="fb4604e63a9a411bbccb36e7a23b3ded57b1e97f6afa5fa1991509fc9c519b30f2ecba0bb4f907a83481ed7754a5814fed8e886484e4ee5c3edcbe58e09b8023"

WORKDIR /z

RUN cat /etc/resolv.conf \
    && wget https://github.com/kamalmostafa/minimodem/archive/minimodem-$MM_VER.tar.gz \
    && echo "$MM_SHA  minimodem-$MM_VER.tar.gz" | sha512sum -c \
    && wget https://github.com/erikd/libsndfile/archive/$SF_VER.tar.gz \
    && echo "$SF_SHA  $SF_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache \
        gcc g++ musl-dev make cmake automake autoconf m4 libtool \
        guile-dev gmp-dev coreutils file bash gzip \
        fftw-dev python3
    #&& wget https://ftp.gnu.org/gnu/autogen/rel$AG_VER/autogen-$AG_VER.tar.gz \
    #&& echo "$AG_SHA  autogen-$AG_VER.tar.gz" | sha512sum -c \

# RUN tar -xvf autogen-$AG_VER.tar.gz \
#     && cd autogen-$AG_VER \
#     && sed -ri 's/-Werror //' configure \
#     && ./configure --disable-dependency-tracking \
#     && make -j4 \
#     && make install

RUN tar -xvf $SF_VER.tar.gz \
    && cd libsndfile-$SF_VER \
    && mkdir b \
    && cd b \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        -DBUILD_SHARED_LIBS=off \
        -DBUILD_PROGRAMS=off \
        -DBUILD_EXAMPLES=off \
        .. \
    && make VERBOSE=1 -j$(nproc) \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install

RUN tar -xvf minimodem-$MM_VER.tar.gz \
    && cd minimodem-minimodem-$MM_VER \
    && ls -al \
    && autoreconf || true \
    && automake --add-missing

RUN cd minimodem-minimodem-$MM_VER \
    && PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig \
       CFLAGS=-fPIC \
       ./configure \
        --without-alsa \
        --without-pulseaudio \
    && make \
        CFLAGS=-static \
        LDFLAGS=-static

RUN mkdir -p /z/rls \
    && cd minimodem-minimodem-$MM_VER/src \
    && cp -pv minimodem minimodem.1 /z/rls \
    && strip /z/rls/minimodem
