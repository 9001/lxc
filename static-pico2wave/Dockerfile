FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="422a3bb69d5f49f9f791b73d72ea7d8aff78d150" \
    SHA="70d40484ca864d39e70c2e2411dc8303a5579f918d934a0700b267599f4fd1dda698c5daba45f1f0013427a58b52873034f6361ce864937c9371daa2273a5801"

RUN wget https://github.com/jpwhiting/svox-pico/archive/$VER.tar.gz \
    && sha512sum $VER.tar.gz \
    && echo "$SHA  $VER.tar.gz" | sha512sum -c \
    && apk add --no-cache \
        gcc musl-dev meson patch

COPY a.patch /z/
RUN tar -xvf $VER.tar.gz \
    && cd svox-pico-$VER \
    && patch -p1 </z/a.patch \
    && LDFLAGS=-static meson setup b \
    && meson compile -Cb 

RUN mkdir -p /z/rls \
    && cp -p */b/bin/pico2wave /z/rls/ \
    && strip /z/rls/* \
    && cp -pR */oldbinfiles /z/rls/pico2wave-voices \
