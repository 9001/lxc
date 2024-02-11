FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z

ENV VER="1.8.5" \
    SHA="6d7a0f785ace5e25c5677af4cf38a003386774e60563865de7f1dae60f1785685541da93e1f88236b8b2e14431584bc2cb2adb3a575fb90dc774bc6bacf22e21"

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
