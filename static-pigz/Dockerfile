FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV PIGZ_VER="2.8" \
    PIGZ_SHA="ae3d9d593e1645d65f9ab77aa828600c9af4bb30d0a073da7ae3dd805e65b87efaf6a0efb980f2d0168e475ae506eba194547d6479956dabb9d88293a9078a7f" \
    ZLIB_VER="1.3" \
    ZLIB_SHA="185795044461cd78a5545250e06f6efdb0556e8d1bfe44e657b509dd6f00ba8892c8eb3febe65f79ee0b192d6af857f0e0055326d33a881449f3833f92e5f8fb"

RUN wget https://zlib.net/pigz/pigz-$PIGZ_VER.tar.gz \
    && sha512sum pigz-$PIGZ_VER.tar.gz \
    && echo "$PIGZ_SHA  pigz-$PIGZ_VER.tar.gz" | sha512sum -c \
    \
    && wget https://www.zlib.net/zlib-$ZLIB_VER.tar.gz \
    && sha512sum zlib-$ZLIB_VER.tar.gz \
    && echo "$ZLIB_SHA  zlib-$ZLIB_VER.tar.gz" | sha512sum -c \
    \
    && apk add --no-cache gcc patch perl musl-dev make

RUN tar -xvf zlib-$ZLIB_VER.tar.gz \
    && cd zlib-$ZLIB_VER \
    && ./configure --static --prefix=/deps \
    && make \
        CFLAGS="-static" \
        LDFLAGS="-static" \
    && make install

RUN tar -xvf pigz-$PIGZ_VER.tar.gz \
    && cd pigz-$PIGZ_VER \
    && make \
        CFLAGS="-static -I/deps/include" \
        LDFLAGS="-static -L/deps/lib"

RUN cd pigz-$PIGZ_VER \
    && strip pigz \
    && mkdir /rls \
    && mv pigz /rls
