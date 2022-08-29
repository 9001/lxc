FROM alpine:3
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="9.0.0322" \
        SHA="0cab72a68d2199412b819f8e4b16f856ae1c9a076e04bf2e69be8c1375d01bd887c4072a66ec8e6fbd657925c275e046ebf67f143c6670d3418b0adc54df4d13"

RUN     apk add --no-cache \
            gcc musl-dev make patch \
            ncurses-static

RUN     wget https://github.com/vim/vim/archive/v$VER.tar.gz -O vim.tgz \
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
