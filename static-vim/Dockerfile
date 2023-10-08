FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

# latest in alpine-edge
ENV     VER="9.0.1888" \
        SHA="4eff10f09c921ad766abbd950724f4f362d506d8c52730d2ed60b317f7b9aa2372ce496e75b65a674e3a250a79f08cc8dcf078f71a1b9858ead469a2cdcfab6f"

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
