FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>
WORKDIR /z/src


ENV PDLZIP_VER="1.11" \
    PDLZIP_SHA="9b0bff340ab125e4bdca231fa129aa30aab6b5a63f2e605de35b4852988a51c933ec22d48e9ba686f66a9286020898ffbbac8edd09e93cce80704d320e349938" \
     LZLIB_VER="1.12" \
     LZLIB_SHA="22497039dbc1f82e574e263bc1857246a592c80e75684a0c7c320dfe8be02b31c1058dc42f6d19d281af4e049e4f56d4ffc6ffeca72f2933db0a3f780a829672" \
       LZD_VER="1.2" \
       LZD_SHA="b0cc3a4b831bc9f7fa466be1e8f31107577e8776178a88548cee91051d7f42f14ee8a434b6e877530d5b69210e2b6884f3a3e23cdd32071b8e4c82511adce1dc" \
# bsd-2-clause above;
# gpl-2.0 below
      LZIP_VER="1.22" \
      LZIP_SHA="ac029a0e7020e7a976e4fbd55fea4c51d37da57f6cb402249467564110f8bd08e9a8bdae835889fe574ddad3d161e1d633e751c0658a1fe94073a9e06b0815bf" \
     CLZIP_VER="1.12" \
     CLZIP_SHA="1db92b78ab2cb280b034a7e60d467ad167b6711386507f44fa192390756b01f217074473bdf550f2f6866bb58675a632fa21948e75e81b57d66eecf8c3d3ddc9" \
     PLZIP_VER="1.9" \
     PLZIP_SHA="20c58feff7deee9ed3762a1d937463485493a3340f499dbf5b2c2004eba12722a12a23977914a78dcf179d0bf6a7841a25983cd55b48fc6e55a70dcc9e4722fa" \
    LUNZIP_VER="1.12" \
    LUNZIP_SHA="b918901e88f14ef0678e872c84c5e4786afd54b3e18c0b58511eb5e8eb5f0d812609f60bd9400df91e81a84af011a45e02f70c64f6cda914a33bf754029939ac" \
    ZUTILS_VER="1.10" \
    ZUTILS_SHA="9ee2dd8dbfcaff2129c5d78fe0ec7c71c601dd298fa84448c1e3835db06a017809384dcdba537c9016b05e448f8cc9ab21332616dee5bb680de151bdffb815f3" \
    LZRECO_VER="1.22" \
    LZRECO_SHA="5d70d6c222d41a9cae9eee7812f0ed869bb668cc079e7ed416d093eec3f6440fdde37a680850446a473a3712dcdce8e3568b193068f834159dbcf6a19bdd0f94" \
     TARLZ_VER="0.21" \
     TARLZ_SHA="1ad671da7ee115762163af57aad69ec754753e68a99ef8c4f38e880ecbb75a5b021f38794390eabcdbef4963cbc0c0e2abe36011da4135baf2c21dc22f020f4a"


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
