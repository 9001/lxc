FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV TMUX_VER="3.2a" \
    TMUX_SHA="6e52c7f5d03b2c8b8c4c8caac092a166956ba97334b426f2823d74dc5849a1d31a80145924f641f69dd2c244809e9350d9bd7070897fa2e3e1f9f086f9b2f365" \
    EVNT_VER="2.1.12" \
    EVNT_SHA="88d8944cd75cbe78bc4e56a6741ca67c017a3686d5349100f1c74f8a68ac0b6410ce64dff160be4a4ba0696ee29540dfed59aaf3c9a02f0c164b00307fcfe84f" \
    U8PR_VER="2.7.0" \
    U8PR_SHA="29f7883de13302d609e8755872ed43174e70076e9681b4ac3f9b03e50295c45d9972c193bc81f94ad7e11e2d33a46cad5a30a80873173e6e1ae242101ebb3bed"

WORKDIR /z

RUN wget https://github.com/tmux/tmux/releases/download/$TMUX_VER/tmux-$TMUX_VER.tar.gz \
    && echo "$TMUX_SHA  tmux-$TMUX_VER.tar.gz" | sha512sum -c \
    && wget https://github.com/libevent/libevent/releases/download/release-$EVNT_VER-stable/libevent-$EVNT_VER-stable.tar.gz \
    && echo "$EVNT_SHA  libevent-$EVNT_VER-stable.tar.gz" | sha512sum -c \
    && wget https://github.com/JuliaStrings/utf8proc/archive/v$U8PR_VER.tar.gz \
    && echo "$U8PR_SHA  v$U8PR_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache \
        gcc g++ musl-dev make automake autoconf m4 libtool bzip2 ncurses-dev ncurses-static cmake

RUN tar -xvf libevent-$EVNT_VER-stable.tar.gz \
    && cd libevent-$EVNT_VER-stable \
    && ls -al \
    && CFLAGS="-fPIC" ./configure --help \
    && CFLAGS="-fPIC" ./configure \
        --enable-static=yes \
        --enable-shared=no \
        --disable-openssl \
        --disable-debug-mode \
        --disable-samples \
        --enable-gcc-hardening \
    && make -j$(nproc) \
        CFLAGS=--static \
        LDFLAGS=--static \
    && make install

RUN tar -xvf v$U8PR_VER.tar.gz \
    && cd utf8proc-$U8PR_VER \
    && mkdir build \
    && cd build \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_FIND_LIBRARY_SUFFIXES=.a \
        -DBUILD_SHARED_LIBS=off \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        .. \
    && make -j1 VERBOSE=1 \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install

RUN tar -xvf tmux-$TMUX_VER.tar.gz \
    && cd tmux-$TMUX_VER \
    && ls -al \
    && CFLAGS="-fPIC" ./configure --help \
    && CFLAGS="-fPIC" ./configure \
        --enable-static \
        --enable-utf8proc \
    && make -j$(nproc) \
        CFLAGS=--static \
        LDFLAGS=--static \
    && make install

RUN mkdir -p /z/rls \
    && cp -pv /usr/local/bin/tmux /z/rls \
    && strip /z/rls/*
