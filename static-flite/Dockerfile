FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

ENV VER="2.1" \
    SHA="e9ef9ca4b6920178634d94bbe6e21a8b0ec471b010b07e6cc961ed2d120acb944c8e1d268fe26188f7dfe43fb7bd4bdff7fa53b2d2f12029d37e08d0316620d2"

RUN wget http://www.festvox.org/flite/packed/flite-$VER/flite-$VER-release.tar.bz2 \
    && echo "$SHA  flite-$VER-release.tar.bz2" | sha512sum -c \
    && apk add --no-cache \
        gcc g++ musl-dev make automake autoconf m4 libtool bzip2

RUN tar -xvf flite-$VER-release.tar.bz2 \
    && cd flite-$VER-release \
    && ls -al \
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
    && cd flite-$VER-release/bin/ \
    && cp -pv flite flite_cmu_us_* /z/rls \
    && strip /z/rls/*


# http://www.festvox.org/flite/packed/flite-2.1/voices/cmu_us_slt.flitevox
# ./flite -voice cmu_us_slt.flitevox -o /dev/shm/tmp.wav -f ~ed/Downloads/txt && mpv /dev/shm/tmp.wav
#
# kal16 sounds better and uses less cpu than kal,
# slt is the best default voice but 13x as expensive as kal16,
# slt.flitevox is much better but 1.5x more expensive than builtin slt
#  (flitevox 2.5x more expensive on 5-word jobs, 3x on 2-word jobs)
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
