FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="9.1.0" \
        SHA="d7038c5c413bfd1a125a893c0b1d3e498e9ce6b5df7d45ef536faac966ce2846b08fe2982010c31f30b34fda07ba2c6922d795806509d05d73768626edc70374"

RUN     apk add --no-cache \
            gcc musl-dev make patch \
            ncurses-static

RUN     wget https://github.com/vim/vim/archive/v$VER.tar.gz -O vim.tgz \
        && sha512sum * \
        && echo "$SHA  vim.tgz" | sha512sum -c

RUN     tar -xf vim.tgz \
        && cd vim-$VER \
        && LDFLAGS="-static -fstack-protector-strong" ./configure \
                --prefix=/tmp/pe-vim \
                --enable-fail-if-missing \
                --enable-multibyte \
                --with-tlib=ncursesw \
                --disable-netbeans \
        && make -j$(nproc) \
        && make install

RUN     mv /tmp/pe-vim /rls \
        && for f in /rls/bin/*; do strip $f; done \
        && cd /rls/share/vim/vim* \
        && rm -rf doc tutor spell \
        && rm /rls/bin/vimtutor
