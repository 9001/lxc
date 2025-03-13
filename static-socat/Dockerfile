FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER="1.8.0.3" \
    SHA="600a3387e9756e0937d2db49de9066df03d9818e4042da6b72109d1b5688dd72352754773a19bd2558fe93ec6a8a73e80e7cf2602fd915960f66c403fd89beef"

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
