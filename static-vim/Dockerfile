FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="9.2.0078" \
        SHA="36ba7d2f7ba339a224d01dd355c41365146a5c4c31af71694b131e95321eefebe546c29a9e32f8c5b75d056f6263072dc5751873ea0995788065469ec2a3420e"

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
		--without-wayland \
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
