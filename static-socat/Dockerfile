FROM alpine:3
MAINTAINER ed <statics@ocv.me>

ENV VER="1.8.1.1" \
    SHA="6235c03187724d57bd98b572780ba8c8648fd2530abc206964666191d48683c7a796499620f7499c688cd11010cdc6f5c7706ac6487ef3ecaba75ca16300cbb7"

RUN wget http://www.dest-unreach.org/socat/download/socat-$VER.tar.gz \
    && sha512sum socat-$VER.tar.gz \
    && echo "$SHA  socat-$VER.tar.gz" | sha512sum -c \
    && wget -O p1.patch https://git.alpinelinux.org/aports/plain/main/socat/use-linux-headers.patch?id=2314c5da5def567a8b93aa1bba5fe288494bc6fc \
    && apk add --no-cache gcc patch perl musl-dev make \
        openssl-dev linux-headers openssl-libs-static

RUN tar -xvf socat-$VER.tar.gz \
    && cd socat-$VER \
    && patch -p1 <../p1.patch \
    && ./configure \
        --disable-readline \
        CFLAGS="-static -Wno-int-conversion" \
        LDFLAGS="-static" \
    && make -j$(nproc)

RUN cd socat-$VER \
    && strip socat \
    && mkdir /rls \
    && mv socat /rls
