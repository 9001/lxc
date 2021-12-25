FROM alpine:3.15 as build
MAINTAINER ed <statics@ocv.me>

WORKDIR /z
ENV VER=1.6.1
RUN apk add --no-cache go git wget musl-dev \
    && wget -O arc https://github.com/cloudflare/cfssl/archive/refs/tags/v${VER}.tar.gz

ENV GOPATH=/z \
    GOROOT=/usr/lib/go \
    CGO_ENABLED=0 \
    GOFLAGS="-trimpath -modcacherw -mod=vendor" \
    LDFLAGS="-s -w -X github.com/cloudflare/cfssl/cli/version.version=${VER} -extldflags \"-static\""


# https://git.alpinelinux.org/aports/tree/testing/cfssl/APKBUILD?id=bf5a28591665f32bc96254c3471d394318863c6d
# https://github.com/golang/go/issues/26492#issuecomment-435462350
#
# go will not have -static until early 1.14; make portable manually
#
# the rice stuff is only necessary if you want serve


RUN go get github.com/GeertJohan/go.rice \
    && go get github.com/GeertJohan/go.rice/rice

RUN tar -xvf arc \
    && mkdir -p src/github.com/cloudflare \
    && mv cfssl-* src/github.com/cloudflare/cfssl \
    \
    && cd $GOPATH/src/github.com/cloudflare/cfssl/cli/serve \
    && /z/bin/rice embed-go \
    \
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
