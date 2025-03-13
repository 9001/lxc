FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER="1.22" \
    SHA="04f338e7b0992c1d94893dc6f2ad80318618690232c7bba43cd9a01ce513052460ed396dca49a060f31dbbb72dcddd59e7f78715dbe0da937a7f3d7725f8d2c1"

RUN wget https://dev.yorhel.nl/download/ncdu-$VER.tar.gz \
    && sha512sum ncdu-$VER.tar.gz \
    && echo "$SHA  ncdu-$VER.tar.gz" | sha512sum -c \
    \
    && apk add --no-cache gcc make musl-dev ncurses-static ncurses-dev

RUN tar -xvf ncdu-$VER.tar.gz \
    && cd ncdu-$VER \
    && ./configure CFLAGS=-static LDFLAGS=-static \
    && make

RUN cd ncdu-$VER \
    && strip ncdu \
    && mkdir /rls \
    && mv ncdu /rls
