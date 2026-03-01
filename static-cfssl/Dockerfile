FROM alpine:3 as build
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER=1.6.5 \
    SHA=b59863d534474ba73efe2dc38b55ba4eb1e0911346b6b9fff7778a3bdc77bf58290ab7173e3ce2cd69f38594dc471ce78632c2aa1cf9188eb6163ca272391185

RUN wget -O arc https://github.com/cloudflare/cfssl/archive/refs/tags/v${VER}.tar.gz \
    && sha512sum arc \
    && echo "$SHA  arc" | sha512sum -c \
    && apk add --no-cache go git wget musl-dev

ENV GOPATH=/z \
    GOROOT=/usr/lib/go \
    CGO_ENABLED=0 \
    GOFLAGS="-trimpath -modcacherw -mod=vendor" \
    LDFLAGS="-s -w -X github.com/cloudflare/cfssl/cli/version.version=${VER} -extldflags \"-static\""


# https://github.com/alpinelinux/aports/blob/master/testing/cfssl/APKBUILD
# https://github.com/golang/go/issues/26492#issuecomment-435462350
#
# go will not have -static until early 1.14; make portable manually


RUN tar -xvf arc \
    && mkdir -p src/github.com/cloudflare \
    && mv cfssl-* src/github.com/cloudflare/cfssl \
    && cd /z/src/github.com/cloudflare/cfssl \
    \
    && echo "building for linux" \
    && go install -tags "pkcs11 netgo osusergo" -ldflags "${LDFLAGS}" ./cmd/... \
    && rm -f /z/bin/rice \
    && mv /z/bin /rls-linux-x64 \
    && strip /rls-linux-x64/* \
    \
    && echo "building for windows" \
    && GOOS=windows GOARCH=386 \
       go install -tags "pkcs11 netgo osusergo" -ldflags "${LDFLAGS}" ./cmd/... \
    && mv /z/bin/windows_386 /rls-windows-x86 \
    \
    && echo done
