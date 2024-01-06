FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER="1.8.0.0" \
    SHA="edf459a9f1907a14025e13b3101ad29787f9a72795cffcd00017ce98847562884db29a95b9ae478a6a50868137548b142947c43fb18e975eb5853a763c42902c"

RUN wget http://www.dest-unreach.org/socat/download/socat-$VER.tar.gz \
    && sha512sum socat-$VER.tar.gz \
    && echo "$SHA  socat-$VER.tar.gz" | sha512sum -c \
    && wget -O p1.patch https://git.alpinelinux.org/aports/plain/main/socat/netdb-internal.patch?id=50e408d10fadde3eca15b42f9abaf79d301abb2c \
    && wget -O p2.patch https://git.alpinelinux.org/aports/plain/main/socat/use-linux-headers.patch?id=50e408d10fadde3eca15b42f9abaf79d301abb2c \
    && apk add --no-cache gcc patch perl musl-dev make \
        openssl-dev>3 linux-headers openssl-libs-static

RUN tar -xvf socat-$VER.tar.gz \
    && cd socat-$VER \
    && ./configure \
        --disable-readline \
        CFLAGS="-static" \
        LDFLAGS="-static" \
    && make -j$(nproc)

RUN cd socat-$VER \
    && strip socat \
    && mkdir /rls \
    && mv socat /rls
