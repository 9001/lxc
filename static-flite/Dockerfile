FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER="2.2" \
    SHA="1ca2f4145651490ef8405fdb830a3b42e885020a7603d965f6a5581b01bed41047d396b38c2ceab138fc0b28d28078db17acd2b5a84c6444cb99d65c581afa72"

RUN wget https://github.com/festvox/flite/archive/v$VER.tar.gz \
    && sha512sum v$VER.tar.gz \
    && echo "$SHA  v$VER.tar.gz" | sha512sum -c \
    && wget http://festvox.org/flite/packed/flite-2.1/voices/cmu_us_slt.flitevox \
    && apk add --no-cache \
        gcc g++ musl-dev patch make automake autoconf m4 libtool bzip2

COPY stdout.patch /w/
RUN tar -xvf v$VER.tar.gz \
    && cd flite-$VER \
    && patch -p1 </w/stdout.patch \
    && sed -ri 's/cmu_us_kal.*/cmu_us_kal16 cmu_us_slt/' config/ben.lv \
    && CFLAGS="-fPIC" ./configure \
        --disable-shared \
        --disable-sockets \
        --with-audio=none \
        --with-langvox=ben \
    \
    && make -C include LDFLAGS="--static" \
    && make -C src     LDFLAGS="--static" \
    && make -C lang    LDFLAGS="--static" \
    && make -C tools   LDFLAGS="--static" \
    && make -j1        LDFLAGS="--static"

RUN mkdir -p /z/rls \
    && cd flite-$VER/bin/ \
    && cp -pv flite /z/rls/ \
    && cp -pv flite_cmu_us_slt /z/rls/flite-slt \
    && cp -pv flite_cmu_us_kal16 /z/rls/flite-kal \
    && strip /z/rls/* \
    && printf '%s\n' '#!/bin/bash' '# to flush, say "\n\n.\n" so for example:  hello world\n\n.\ngoodnight\n\n\.\n' './flite-kal -voice cmu_us_slt.flitevox -s duration_stretch=0.9 -o stream | ffmpeg -probesize 32 -v 24 -f s16le -ar 16000 -i - -af bandreject=f=172:t=q:w=1:m=0.9,volume=1.8 -f alsa default' >/z/rls/cmu_us_slt.sh \
    && chmod 755 /z/rls/cmu_us_slt.sh \
    && mv /z/*.flitevox /z/rls/


# http://www.festvox.org/flite/packed/flite-2.1/voices/cmu_us_slt.flitevox
# ./flite -voice cmu_us_slt.flitevox -o /dev/shm/tmp.wav -f ~ed/Downloads/txt && mpv /dev/shm/tmp.wav
#
# kal16 sounds better and uses less cpu than kal,
# slt is the best default voice but 13x as expensive as kal16,
# slt.flitevox is much better but 1.5x more expensive than builtin slt
#  (flitevox 2.5x more expensive on 5-word jobs, 3x on 2-word jobs)
#
# slt has a slightly-moving hum/resonance around 172hz (exact freq
#  depends on f0_shift and int_f0_target_mean); fix with bandreject
#
# below is time spent reading 1000 words using each voice,
# first column absolute time in seconds,
# the others are comparisons with different reference points
#
#                 kal   2.09    7%   162%   12%
#               kal16   1.29    5%   100%    7%
#                 awb  18.07   65%  1401%  101%
#                 rms  21.92   78%  1699%  123%
#                 slt  17.82   64%  1381%  100%
# cmu_us_slt.flitevox  27.93  100%  2165%  157%
