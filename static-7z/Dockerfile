FROM alpine:3.15
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV     VER="17.04" \
        SHA="ad176db5b657b1c39584f6792c47978d94f2f1ccb1cf5bdb0f52ab31a7356b3822f4a922152c4253f4aa7e79166ba052b6592530b7a38f548cd555fe9c008be3"

RUN     apk add --no-cache \
            gcc g++ musl-dev make patch \
            attr-dev util-linux-dev linux-headers

RUN     wget https://github.com/szcnick/p7zip/archive/v$VER.tar.gz -O 7z.tgz \
        && echo "$SHA  7z.tgz" | sha512sum -c

RUN     tar -xvf 7z.tgz \
        && cd p7zip-$VER \
        && make LDFLAGS="-static" -j4 7za \
        && make LDFLAGS="-static" -j4 sfx
# 'all' is broken, should have been "" (7za) + "sfx" (7zCon.sfx)

# tests are broken too
#RUN     cd p7zip-$VER \
#        && chmod 755 check/check.sh \
#        && make test

RUN     mkdir /rls \
        && cd /z/p7zip-${VER}/bin \
        && mv * /rls \
        && for f in /rls/*; do strip $f; done
