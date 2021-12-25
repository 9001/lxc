FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV XD3_VER="3.0.11" \
    XD3_SHA="ef8aa4826611fcb751cb5de49908fef866490d8866502ca3b4a4409e0698d058b5bae5bb5ba8934f8e68c07cd202cba74e4907c4ce8eb6e709f6a5621d30cdc7"

RUN wget https://github.com/jmacd/xdelta/archive/v$XD3_VER.tar.gz \
    && sha512sum v$XD3_VER.tar.gz \
    && echo "$XD3_SHA  v$XD3_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache \
        gcc g++ musl-dev make automake autoconf m4 libtool

RUN tar -xvf v$XD3_VER.tar.gz \
    && cd xdelta-$XD3_VER/xdelta3 \
    && ls -al \
    && libtoolize \
    && aclocal \
    && autoheader \
    && automake --add-missing \
    && autoreconf \
    && ./configure --help \
    && ./configure \
        --enable-shared=no \
        --enable-static=yes

RUN cd xdelta-$XD3_VER/xdelta3 \
    && ls -al \
    && make \
        LDFLAGS="--static" \
        EXEEXT="-static"

RUN cd xdelta-$XD3_VER/xdelta3 \
    && strip xdelta3-static \
    && cp -pv xdelta3-static /
