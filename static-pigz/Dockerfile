FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV PIGZ_VER="2.6" \
    PIGZ_SHA="04d2e44bc7a7eb061c3c48100ce5b8fc79931aeac72340abd768fd2a4499ff1004e2bc009772fc2003a4c599f6e90f3abc8bef5c377d6397f1c8e9f7c49f95e2" \
    ZLIB_VER="1.2.11" \
    ZLIB_SHA="73fd3fff4adeccd4894084c15ddac89890cd10ef105dd5e1835e1e9bbb6a49ff229713bd197d203edfa17c2727700fce65a2a235f07568212d820dca88b528ae"

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
        EXEEXT="-static" \
    && make install

RUN tar -xvf pigz-$PIGZ_VER.tar.gz \
    && cd pigz-$PIGZ_VER \
    && make \
        CFLAGS="-static -I/deps/include" \
        LDFLAGS="-static -L/deps/lib" \
        EXEEXT="-static"

RUN cd pigz-$PIGZ_VER \
    && strip pigz \
    && cp -pv pigz /pigz-static
