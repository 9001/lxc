FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z/src


ENV PDLZIP_VER="1.14" \
    PDLZIP_SHA="82a82228c0d6aaf970affe4d7d0269dbdc444d25ed97dc14839cfa436c30e61e029b0c5b78bf4715a55992f72017cbcc1ac930ad1f284c84ea02f0023e82b0ca" \
     LZLIB_VER="1.15" \
     LZLIB_SHA="c9835657a17509d58bc9ed07e22199b0632954eb3fd1d2144cdfac8cad9d191e1175885c42261cd79b6f366bf9d3318007a26943a495585a999e1f49d41fb1e7" \
       LZD_VER="1.5" \
       LZD_SHA="f7d81d3e498ebf23ed28639226d8389c4a512c880a1268bb2b8eabdd6ce7b1c1be881de37356fdabe6dac2483e82799c8a6b0bfb43f817360e618e4b5ef597a9" \
# bsd-2-clause above;
# gpl-2.0 below
      LZIP_VER="1.25" \
      LZIP_SHA="c7171edb5dcd11476fcb1a8af9b81a382f250c6fc66601f67c3a78cc7450ecc4ac1647d8942d4c57b392647f136166838753b8fac5c2718c1b16b06b010e358b" \
     CLZIP_VER="1.15" \
     CLZIP_SHA="6261788dedb6c52aabeec217e0444e3042df5e482202abe84d6cd04fe64b51815513fd6f3302df44b6396843e909023d600a65b0edca1f1b76efcb47880a7772" \
     PLZIP_VER="1.12" \
     PLZIP_SHA="010524627b946692821b8caba47bd12ee5d7f27792017b439936b256ef121063fa10474d79c223249b8e744b6fa4d9181101280cc5e9e201af22663c830aaef2" \
    LUNZIP_VER="1.15" \
    LUNZIP_SHA="6377b340a5ffbc5170ce60743644293514d319622b9cee1dd5ff36ebec6de584430263560cd71a44dcd561643081824016aa14cffa20c0ab46e6e656bd5aac63" \
    ZUTILS_VER="1.16" \
    ZUTILS_SHA="2f89a6366c107bf3e316bc79a1d7e02a39b4efc74bad81951a153076f4e0b0b1f4f7e8bd239c8f43a9ccda9d721238d6877e19cce231c27f0ddb43852a8da1d8" \
    LZRECO_VER="1.26" \
    LZRECO_SHA="b4c9967b1adccb73afc99434ac9ae787fd5207576f7d0038a4fe903ff8b2cae5d7d512ed45444201006747bb9bd1edbf67925a849dd129ca765ccda510c85632" \
     TARLZ_VER="0.29" \
     TARLZ_SHA="18e575abc2cc02201a0da3ea404ca4db62a3d8a3109e1de3e4ece43dfb9f08b8b7b0dc1083d1effac1b64408d6b93498cc75d04f14cf721d3eb16864af7f2504"


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
