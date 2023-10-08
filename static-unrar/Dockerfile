FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

# https://www.rarlab.com/rar_add.htm
ENV VER="6.2.11" \
    SHA="07504d5a08ae12190b43c6898e11cebc868ae373eae756ebb8a446c5c5a42ef456652e86a81dc855a23edae43144be3bf55e57768e7b4fa188ab4368cfa0657e"

COPY makefile.patch /z

RUN apk add --no-cache \
        gcc g++ musl-dev make patch \
        attr-dev util-linux-dev linux-headers

RUN wget https://www.rarlab.com/rar/unrarsrc-$VER.tar.gz -O unrar.tgz \
    && sha512sum unrar.tgz \
    && echo "$SHA  unrar.tgz" | sha512sum -c

RUN tar -xvf unrar.tgz \
    && cd unrar \
    && patch -p1 < /z/makefile.patch \
    && make LDFLAGS="-static" -j$(nproc)

RUN mkdir /rls \
    && mv /z/unrar/unrar /rls/ \
    && for f in /rls/*; do strip $f; done
