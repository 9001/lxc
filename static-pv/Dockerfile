FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="1.9.31" \
    SHA="63cdc6223cde4f3f0daf47b5808a3f72a9cfaf2c05751e971a99d9dd3df2f36430958213c023931f428c87341a5f6c1f3772f30ca992123ea4c2a2e48000ff1d"

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
