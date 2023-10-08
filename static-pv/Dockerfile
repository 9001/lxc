FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="1.8.0" \
    SHA="575b4ddbb23ffad9995f597595f58a92ccf9d0ff910d5fdfb513ed553238a1971c3bc09f473cabcf72fd2961ceff0b9fa0e4b8a7e06c3382e21a44551d90b7a8"

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
