FROM alpine:3
MAINTAINER ed <statics@ocv.me>
WORKDIR /z/src


ENV PDLZIP_VER="1.13" \
    PDLZIP_SHA="924f698b39f28baa76fb2b3a2e2046f53c7770de31bb07e2e4451ee2361dc40fbc82eecc1ccba86cd7c428e4e9bbb9a82f12a39a450dcc4f28a7f71d55848f47" \
     LZLIB_VER="1.14" \
     LZLIB_SHA="62f4676992077e840084324de0eafedc375b3e14e71406d998c54b9d2a180126f2e381ed73e8ed1ff37dac41ec18b2bd42d5930725b63633ddbac11fc4ca4a62" \
       LZD_VER="1.4" \
       LZD_SHA="85c36a2cb317654a93a7ca22a2c8e7b3c3a13755af858452fa3366147ac22483146ec419ad0cb58e05d9671aca5587004cb6e9c545f2cea4c262ca671c241cad" \
# bsd-2-clause above;
# gpl-2.0 below
      LZIP_VER="1.24" \
      LZIP_SHA="2a47f573801c0f3c6bb63cd2f486ba62cbff7267346f62b7b55ae2420b316863c3ae42ec6b79de7998d31b7053afbfd12d3cdaf11ba617357f6ea557c308ba1e" \
     CLZIP_VER="1.14" \
     CLZIP_SHA="4f7f94bd1571acbf6d79a7265db247e793e3a79ec4772f01358fc22687e9932ca012d3d84ebb562ed0e4d1a335aa5c75cdab4d4cdcd9e636e7fdffc9854d8871" \
     PLZIP_VER="1.11" \
     PLZIP_SHA="db96b7722cf7f1e1d861d88120eca6ed0fa04c0a76df17148150f17ae7fcaacb9a963801a5da09478ef065cb185d0fb8a4681963ff4c2b4a96cc03acf6bbd599" \
    LUNZIP_VER="1.14" \
    LUNZIP_SHA="20864e720e94c4c421c14693d82d69c017562184bdd461a45c5e3ba820d3da842c8f826d989d1295483f305c4fa49c652ac3a3f1f311ae9c1da7a7f06647cd98" \
    ZUTILS_VER="1.13" \
    ZUTILS_SHA="d0decf5890b091845b8f1b6fa2541961e54be888ae0c6e54512b6296c9a3bcb2ff80d2b9a2f2644c4aa51cc8a4e0d031138a027d6a76b779fb5cd5c45aa24f14" \
    LZRECO_VER="1.24" \
    LZRECO_SHA="40e2e556ddbc4588da64677e627262b0d8b3179338ddb8579ec3e28abab180176f18980be899b81b6ddeda3f4eb4fc8796fd1ec4a7d2af46baa928ef5bd19453" \
     TARLZ_VER="0.25" \
     TARLZ_SHA="a55e89c3e701375d47f6fefd3cba5621f53371f3b3e59c174759e5d122f852b6eec02f5e71ce375b84d6af253841ad4b0d4c8a8af8fc12b81f877f0ab8c3b3c8"


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
