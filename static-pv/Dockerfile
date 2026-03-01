FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="1.10.3" \
    SHA="19d48f004cf06e36b1157c701afb4612a3a38997d74195cf9e79250cda085d4bf724d954504c4d88368a6af099a9eaa872da33e96848bbdce325f52ad40e6947"

RUN wget http://www.ivarch.com/programs/sources/pv-$VER.tar.gz \
    && sha512sum pv-$VER.tar.gz \
    && echo "$SHA  pv-$VER.tar.gz" | sha512sum -c \
    && apk add --no-cache gcc g++ musl-dev make

RUN tar -xvf pv-$VER.tar.gz \
    && cd pv-$VER \
    && ./configure --prefix=/z/b --enable-static \
    && make pv

# -fPIE -lc
#            CFLAGS="-static -lc" \
#            LDFLAGS="--static --entry main -lc" \
#            EXEEXT="-static" \

RUN cd pv-$VER \
    && strip pv \
    && mkdir /rls \
    && mv pv /rls
