FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER="1.21" \
    SHA="10ffb2fdacf465a410e8733acc3f2f7f6304998e8e6cb9b4c42b5c6aa6e588ef7d262b72d5d83d8bbc80964fa9850b4b4a9bc9c58224fb41598eeae399771674"

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
