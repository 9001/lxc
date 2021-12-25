FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

# use latest commit in devel branch of dsp
ENV FEC_VER="9750ca0a6d0a786b506e44692776b541f90daa91" \
    FEC_SHA="bce42f38d00f364ee9d0d46546778ff34a971c8ebacbb53166f36689893bc379a2cff611d5a1611778055ef7674a970c426743c61d2bda964c5dd082526b55fd" \
    DSP_VER="4951bbbf67a9857dbaab0bc6fa69801717308109" \
    DSP_SHA="7cd35dce52ce72612305717dd130abfc9a6ef6c94624807d2179bb504e749f5c2a882db5283a06b5731cb5ed8305c617c085f7b708a35df9f9fb1a4d3ea5f693" \
    QUI_VER="b64a058ed40a49a8ff777bfb526f2989480eb1ec" \
    QUI_SHA="1156f739a6378738b1e122a61deb99d519c240d756258f86828bdec2c8a22dfeba0403d94894006566ebf64b9bc1cde0254459a039fbb248d268e5d731e7be07" \
    SF_VER="d60deb5d8691997b6bb28d88e3b43f322073d146" \
    SF_SHA="b04a99fad706c3e7f10f729a79d1648ea58b0a064cc784d91fdf4a5cb2ff8d779b62cc95ada83755c6b8de787c3e98025cc6a05db11f81890c657f81236def76" \
    JAN_VER="2.14" \
    JAN_SHA="5a592776c7ba8c0b1f5efaf813f77948bbc4bda168a72d221d176af0cf61038e26c1f30795433be10e2fc5069d5763d11852a8574774906a9f8ad261ac30109c"

WORKDIR /z

RUN cat /etc/resolv.conf \
    && wget https://github.com/quiet/libfec/archive/$FEC_VER.tar.gz -O fec.tgz \
    && echo "$FEC_SHA  fec.tgz" | sha512sum -c \
    && wget https://github.com/quiet/quiet-dsp/archive/$DSP_VER.tar.gz -O dsp.tgz \
    && echo "$DSP_SHA  dsp.tgz" | sha512sum -c \
    && wget https://github.com/quiet/quiet/archive/$QUI_VER.tar.gz -O quiet.tgz \
    && echo "$QUI_SHA  quiet.tgz" | sha512sum -c \
    && wget https://github.com/erikd/libsndfile/archive/$SF_VER.tar.gz \
    && echo "$SF_SHA  $SF_VER.tar.gz" | sha512sum -c \
    && wget https://github.com/akheron/jansson/releases/download/v$JAN_VER/jansson-$JAN_VER.tar.gz \
    && echo "$JAN_SHA  jansson-$JAN_VER.tar.gz" | sha512sum -c \
    && apk add --no-cache \
        gcc g++ musl-dev make automake autoconf patch \
        guile-dev gmp-dev coreutils file bash gzip \
        fftw-dev python3 cmake

RUN tar -xvf $SF_VER.tar.gz \
    && cd libsndfile-$SF_VER \
    && mkdir b \
    && cd b \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        -DBUILD_SHARED_LIBS=off \
        -DBUILD_PROGRAMS=off \
        -DBUILD_EXAMPLES=off \
        .. \
    && make VERBOSE=1 -j$(nproc) \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install

RUN tar -xvf fec.tgz \
    && cd libfec-$FEC_VER \
    && mkdir b \
    && cd b \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_FIND_LIBRARY_SUFFIXES=.a \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        -DBUILD_SHARED_LIBS=off \
        .. \
    && make VERBOSE=1 \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install

RUN tar -xvf dsp.tgz \
    && cd quiet-dsp-$DSP_VER \
    && sed -ri /fft_r2r_test/d sandbox/CMakeLists.txt \
    && mkdir b \
    && cd b \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_FIND_LIBRARY_SUFFIXES=.a \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        -DLIQUID_BUILD_SHARED=off \
        -DLIQUID_FFTOVERRIDE=on \
        -DLIQUID_SIMDOVERRIDE=on \
        .. \
    && make -j$(nproc) \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install

RUN tar -xvf jansson-$JAN_VER.tar.gz \
    && cd jansson-$JAN_VER \
    && mkdir b \
    && cd b \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        -DJANSSON_EXAMPLES=off \
        .. \
    && make VERBOSE=1 -j$(nproc) \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install

COPY quiet.patch /z/

RUN tar -xvf quiet.tgz \
    && cd quiet-$QUI_VER \
    && patch -p1 < /z/quiet.patch \
    && mkdir b \
    && cd b \
    && CFLAGS=-fPIC cmake \
        -DCMAKE_FIND_LIBRARY_SUFFIXES=.a \
        -DCMAKE_EXE_LINKER_FLAGS="-static -static-libgcc -static-libstdc++" \
        -DCMAKE_C_FLAGS=-static \
        -DBUILD_SHARED_LIBS=off \
        .. \
    && make VERBOSE=1 \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install \
    && mv /usr/local/bin/quiet_encode_file /usr/local/bin/quiet-encode \
    && mv /usr/local/bin/quiet_decode_file /usr/local/bin/quiet-decode

RUN cd quiet-$QUI_VER/b \
    && sed -ri 's/(SAMPLE_RATE =) [0-9]+;/\1 48000;/' ../include/quiet/common.h \
    && sed -ri 's/(sample_rate =) [0-9]+;/\1 48000;/' ../programs/encode_file.c \
    && make VERBOSE=1 \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install \
    && mv /usr/local/bin/quiet_encode_file /usr/local/bin/quiet-48-encode \
    && mv /usr/local/bin/quiet_decode_file /usr/local/bin/quiet-48-decode

RUN cd quiet-$QUI_VER/b \
    && sed -ri 's/(SAMPLE_RATE =) [0-9]+;/\1 96000;/' ../include/quiet/common.h \
    && sed -ri 's/(sample_rate =) [0-9]+;/\1 96000;/' ../programs/encode_file.c \
    && make VERBOSE=1 \
        CFLAGS="-static -fPIC" \
        LDFLAGS=-static \
    && make install \
    && mv /usr/local/bin/quiet_encode_file /usr/local/bin/quiet-96-encode \
    && mv /usr/local/bin/quiet_decode_file /usr/local/bin/quiet-96-decode

RUN mkdir -p /z/rls \
    && cd /usr/local \
    && cp -pv \
        bin/quiet* \
        quiet-profiles.json \
        /z/rls \
    && strip /z/rls/quiet-*code


# (cd patch/quiet/ && diff -wNarU5 orig mod > the.patch); make && (cd rls/ && echo hello | ./quiet-encode-wav cable-64k cable-64k.wav)

# p=cable-64k; (cat ../res/header-44khz.wav; ./quiet-encode $p - quiet-profiles.json) | tee wav | ./quiet-decode $p /dev/stdin | cmp quiet-profiles.json 
