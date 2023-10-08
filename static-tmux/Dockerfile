FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV TMUX_VER="3.3a" \
    TMUX_SHA="29a846df7d93601c42a22f84f606931dc65da1f70b67d351d0425f77ea3affe3e8218b2940d42cd3dadf3cd1aa95032daad3ecb14fbff0f69939d1beae0498c7" \
    EVNT_VER="2.1.12" \
    EVNT_SHA="88d8944cd75cbe78bc4e56a6741ca67c017a3686d5349100f1c74f8a68ac0b6410ce64dff160be4a4ba0696ee29540dfed59aaf3c9a02f0c164b00307fcfe84f" \
    U8PR_VER="2.8.0" \
    U8PR_SHA="4b9853fc95db38bee1d7435bef219907e25b249e0c2ec26f7096b8506ab2a139a8d4b71f7133b7550bff59d8f997fe01c2957d362cad18d890ad82bcf158aa06"

WORKDIR /z

RUN wget https://github.com/tmux/tmux/releases/download/$TMUX_VER/tmux-$TMUX_VER.tar.gz \
    && wget https://github.com/libevent/libevent/releases/download/release-$EVNT_VER-stable/libevent-$EVNT_VER-stable.tar.gz \
    && wget https://github.com/JuliaStrings/utf8proc/archive/v$U8PR_VER.tar.gz \
    && sha512sum * \
    && echo "$TMUX_SHA  tmux-$TMUX_VER.tar.gz" | sha512sum -c \
    && echo "$EVNT_SHA  libevent-$EVNT_VER-stable.tar.gz" | sha512sum -c \
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
