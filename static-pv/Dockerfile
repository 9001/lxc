FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="1.6.20" \
    SHA="e445f91b298ed285ddab54a3f8a6b5d5297e2e2eb8ad7b2ee2cbacca4adda9c6ca2bf3c77bf2a93373d3875c5b3b0b345d3945cbd91fc2647c6c25f1661a6752"

RUN wget http://www.ivarch.com/programs/sources/pv-$VER.tar.bz2 \
    && echo "$SHA  pv-$VER.tar.bz2" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make

RUN tar -xvf pv-$VER.tar.bz2 \
    && cd pv-$VER \
    && ./configure --prefix=/z/b \
    && make pv-static

# -fPIE -lc
#            CFLAGS="-static -lc" \
#            LDFLAGS="--static --entry main -lc" \
#            EXEEXT="-static" \

RUN cd pv-$VER \
    && strip pv-static \
    && cp -pv pv-static /pv-static
