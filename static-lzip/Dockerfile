FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z/src


ENV PDLZIP_VER="1.12" \
    PDLZIP_SHA="461482c48db9f1be3d89981215e31ab29abbbea52210e67182f73bdcac5769a8833f686e2763df78495f6cda4075417ccf3c6db4aeca6c94ff261aeb561cf174" \
     LZLIB_VER="1.13" \
     LZLIB_SHA="780531ddad16b907a80d417c65d0c1010b86943a600a69147f51884f3332483bd889dc31b4d7ce897a4ff53e71a5bc28fae7e5ef30e4408e7f3830ab8bdf94e1" \
       LZD_VER="1.3" \
       LZD_SHA="eeba0019738dd491de8af07944549cd2e2f83a3c255fbd2df3914192e8e956f3db8cc9c799fe36a0bea3007abc6364fa105beb93a9095e0de32557cf4623093b" \
# bsd-2-clause above;
# gpl-2.0 below
      LZIP_VER="1.23" \
      LZIP_SHA="c74d8bf6ae62b35160faf336d5bccdf7d187a90b6e08cda96d18212feed40a430124d7f5c8e91891fabcb279b67763bc5bbd95a895005771a423eb06a80c5a8a" \
     CLZIP_VER="1.13" \
     CLZIP_SHA="ac19bb9e13963afb3ddf88d584f3bdaa7dcc84fb5ec72976caf603c3537524febdef8dd8bf01ee11f7d00874c1804448bed82cbfdec3fc90ceaae590860f93fc" \
     PLZIP_VER="1.10" \
     PLZIP_SHA="3233028a1294805da15856194fa94701e3abf3e5322e56ac631ad547b0b03995fabb5a7c4292e807f1be5b1cbfd6c6324af165691858da35b699c4e4e6927ed4" \
    LUNZIP_VER="1.13" \
    LUNZIP_SHA="a9f4f3d3b98073ba194f4491286731334615b3a0ca589b7bbbe9a537a0f7f87e24042f73b8bf2ea5df3ac7594ccd7ebe99cefa95b95703fd390e374dbc987e0b" \
    ZUTILS_VER="1.12" \
    ZUTILS_SHA="9f587b8729b669799a3596043c575d1a12c7d29e4d92a1ebc9d6868f45248720f9d30a5a6de7c8b770161c0544ac6ee572d70dda0a6e39b50f7e501d5b037d0c" \
    LZRECO_VER="1.23" \
    LZRECO_SHA="50cc0e030d996c1ff167a0f6dfbcbfa9076e0d8c4f3edf1049db9e399e65f13cdf39e436fd99e6b11b9d03435d370a2e0a1daf0dfcfa5fbf28a6329ff1e88bc2" \
     TARLZ_VER="0.24" \
     TARLZ_SHA="8aa617ce016675b24c3286ca44afef2801f37b8f617f89665aedd20266fdde1bc8a0ad6293a70b788fb36ad1f5c761d3141c26ab7b4615c8625d72f11c680d5c"


RUN wget \
        https://download-mirror.savannah.gnu.org/releases/lzip/pdlzip/pdlzip-$PDLZIP_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/lzlib/lzlib-$LZLIB_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/lzd/lzd-$LZD_VER.tar.lz \
        \
        https://download-mirror.savannah.gnu.org/releases/lzip/lzip-$LZIP_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/clzip/clzip-$CLZIP_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/plzip/plzip-$PLZIP_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/lunzip/lunzip-$LUNZIP_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/zutils/zutils-$ZUTILS_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/lziprecover/lziprecover-$LZRECO_VER.tar.lz \
        https://download-mirror.savannah.gnu.org/releases/lzip/tarlz/tarlz-$TARLZ_VER.tar.lz \
    \
    && sha512sum * \
    && echo "$PDLZIP_SHA  pdlzip-$PDLZIP_VER.tar.lz" | sha512sum -c \
    && echo  "$LZLIB_SHA  lzlib-$LZLIB_VER.tar.lz"   | sha512sum -c \
    && echo    "$LZD_SHA  lzd-$LZD_VER.tar.lz"       | sha512sum -c \
    \
    && echo   "$LZIP_SHA  lzip-$LZIP_VER.tar.lz"     | sha512sum -c \
    && echo  "$CLZIP_SHA  clzip-$CLZIP_VER.tar.lz"   | sha512sum -c \
    && echo  "$PLZIP_SHA  plzip-$PLZIP_VER.tar.lz"   | sha512sum -c \
    && echo "$LUNZIP_SHA  lunzip-$LUNZIP_VER.tar.lz" | sha512sum -c \
    && echo "$LZRECO_SHA  lziprecover-$LZRECO_VER.tar.lz" | sha512sum -c \
    && echo "$ZUTILS_SHA  zutils-$ZUTILS_VER.tar.lz" | sha512sum -c \
    && echo  "$TARLZ_SHA  tarlz-$TARLZ_VER.tar.lz"   | sha512sum -c \
    \
    && apk add --no-cache gcc g++ musl-dev make tar lzip


RUN    tar -Ilzip -xf pdlzip-$PDLZIP_VER.tar.lz \
    && tar -Ilzip -xf lzlib-$LZLIB_VER.tar.lz \
    && tar -Ilzip -xf lzd-$LZD_VER.tar.lz \
    \
    && tar -Ilzip -xf lzip-$LZIP_VER.tar.lz \
    && tar -Ilzip -xf clzip-$CLZIP_VER.tar.lz \
    && tar -Ilzip -xf plzip-$PLZIP_VER.tar.lz \
    && tar -Ilzip -xf lunzip-$LUNZIP_VER.tar.lz \
    && tar -Ilzip -xf lziprecover-$LZRECO_VER.tar.lz \
    && tar -Ilzip -xf zutils-$ZUTILS_VER.tar.lz \
    && tar -Ilzip -xf tarlz-$TARLZ_VER.tar.lz \
    \
    && cd /z/src/pdlzip-$PDLZIP_VER \
    && ./configure \
        --prefix=/z/inst \
        CFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/lzd-$LZD_VER \
    && ./configure \
        --prefix=/z/inst \
        CXXFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/lzip-$LZIP_VER \
    && ./configure \
        --prefix=/z/inst \
        CXXFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/clzip-$CLZIP_VER \
    && ./configure \
        --prefix=/z/inst \
        CFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/lunzip-$LUNZIP_VER \
    && ./configure \
        --prefix=/z/inst \
        CFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/zutils-$ZUTILS_VER \
    && ./configure \
        --prefix=/z/inst \
        CXXFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/lziprecover-$LZRECO_VER \
    && ./configure \
        --prefix=/z/inst \
        CXXFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/lzlib-$LZLIB_VER \
    && ./configure \
        --prefix=/z/inst \
        CFLAGS+=-static \
        LDFLAGS=-static \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/plzip-$PLZIP_VER \
    && ./configure \
        --prefix=/z/inst \
        CXXFLAGS+="-static -I/z/inst/include" \
        LDFLAGS="-static -L/z/inst/lib" \
    && make -j$(nproc) \
    && make install \
    \
    && cd /z/src/tarlz-$TARLZ_VER \
    && ./configure \
        --prefix=/z/inst \
        CXXFLAGS+="-static -I/z/inst/include" \
        LDFLAGS="-static -L/z/inst/lib" \
    && make -j$(nproc) \
    && make install


RUN cd /z/inst/bin \
    && rm -f zegrep zfgrep \
    && strip * \
    && mv /z/inst/bin /z/rls \
    && find /z/src/ -type d -mindepth 1 -maxdepth 1 -exec rm -rf {} +

# for p in clzip lunzip lzd lzip lzlib pdlzip plzip lzreco zutils tarlz; do echo; grep --color=always -iE "(^|[^a-zA-Z0-9])$p([^a-zA-Z0-9]|$)" Dockerfile; done | sed -r 's/\[01;31m/[01;37;41m/g'
