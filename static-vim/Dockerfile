FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="9.1.1105" \
        SHA="f109771344afb84ff77a1c616e5dc96456580222552233b935a6c4c13cc04eab474f889d51132ffb78edbe9d76ab50ce1022ef9deafcadf57e4b4f7bbe1ab4d9"

RUN     apk add --no-cache \
            gcc musl-dev make patch \
            ncurses-dev ncurses-static

RUN     wget https://github.com/vim/vim/archive/v$VER.tar.gz -O vim.tgz \
        && sha512sum * \
        && echo "$SHA  vim.tgz" | sha512sum -c

RUN     tar -xf vim.tgz \
        && cd vim-$VER \
        && LDFLAGS="-static -fstack-protector-strong -flto=auto" ./configure \
                --prefix=/tmp/pe-vim \
                --enable-fail-if-missing \
                --enable-multibyte \
                --with-tlib=ncursesw \
                --enable-gui=no \
                --without-x \
                --disable-nls \
                --disable-netbeans \
        && make -j$(nproc) \
        && make install

COPY    vimrc /tmp/pe-vim/share/vim/vimrc

RUN     mv /tmp/pe-vim /rls \
        && for f in /rls/bin/*; do strip $f; done \
        && cd /rls/share/vim/vim* \
        && rm -rf doc tutor spell \
        && rm /rls/bin/vimtutor
