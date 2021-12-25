FROM alpine:3.15 as build
MAINTAINER ed <statics@ocv.me>

WORKDIR /z

ENV VER=1.18.5 \
    SHA=282e6a700568946ed23d04cda41fa6a86d7c390c12c8abf99897f3818db9b4452baf5ab47d082bcf0b6a0329eb3d073dbc3abfe4a6493835cd201399307f605d \
    GOPATH=/z

RUN apk add --no-cache go git wget musl-dev \
    && wget -O arc https://github.com/syncthing/syncthing/releases/download/v$VER/syncthing-source-v$VER.tar.gz \
    && mkdir /rls

# take everything except "all" from: var targets = map[string]target{
#  = syncthing stdiscosrv strelaysrv strelaypoolsrv
# take a selection from: cmd/
#  = stcli stevents stindex stvanity

ENV TGTS="syncthing stdiscosrv strelaysrv strelaypoolsrv" \
    TGTS2="stcli stevents stindex stvanity"


RUN tar -xf arc \
    && cd syncthing \
    && echo "patching" \
    && sed -ri 's/(if )(isSuperUser)/\1false \&\&\2/' lib/syncthing/syncthing.go \
    && sed -ri 's/(GlobalAnnEnabled|RelaysEnabled|StartBrowser|CREnabled|NATEnabled)(.*default:")true/\1\2false/' lib/config/optionsconfiguration.go \
    && sed -ri 's/(URAccepted.*" )/\1default="-1" /' lib/config/optionsconfiguration.go \
    \
    && echo "building for linux" \
    && for tgt in $TGTS; do \
        echo "linux: $tgt" \
        && \
        CGO_ENABLED=0 \
        EXTRA_LDFLAGS='-extldflags "-static"' \
        go run build.go \
            -no-upgrade \
            -goos linux \
            -goarch amd64 \
            build $tgt \
    ; done \
    && for tgt in $TGTS; do \
        ls -al $tgt \
        && strip $tgt \
        && mv $tgt /rls/ \
    ; done \
    && CGO_ENABLED=0 \
        EXTRA_LDFLAGS='-extldflags "-static"' \
        go run build.go \
            -no-upgrade \
            -goos linux \
            -goarch amd64 \
            tar \
    && mv syncthing-linux-*.tar.gz /rls/ \
    && ls -al /rls/


## separate step for "all" since it's buggy
#RUN cd syncthing \
#    && echo "building linux:all" \
#    && rm -rf cmd/stupgrades \
#    && CGO_ENABLED=0 \
#        EXTRA_LDFLAGS='-extldflags "-static"' \
#        go run build.go \
#            -no-upgrade \
#            -goos linux \
#            -goarch amd64 \
#            build all
#RUN cd syncthing \
#    && for tgt in $TGTS2; do \
#        ls -al $tgt \
#        && strip $tgt \
#        && mv $tgt /rls/ \
#    ; done


# nevermind "all" does litearlly nothing
RUN cd syncthing \
    && echo "building linux:all-subset" \
    && for tgt in $TGTS2; do \
        echo "building linux:$tgt" \
        && (cd cmd/$tgt \
            && CGO_ENABLED=0 \
                GOOS=linux \
                GOARCH=amd64 \
                go build \
                    -ldflags '-extldflags "-static"' \
                    -tags noupgrade \
        ); done

RUN cd syncthing \
    && for tgt in $TGTS2; do \
        (cd cmd/$tgt \
        && ls -al $tgt \
        && strip $tgt \
        && mv $tgt /rls/ \
    ); done







RUN cd syncthing \
    && echo "building for windows" \
    && for tgt in $TGTS; do \
        echo "windows: $tgt" \
        && \
        CGO_ENABLED=0 \
        EXTRA_LDFLAGS='-extldflags "-static"' \
        go run build.go \
            -no-upgrade \
            -goos windows \
            -goarch 386 \
             build $tgt \
        ; done \
    && for tgt in $TGTS; do \
        ls -al $tgt.exe \
        && mv $tgt.exe /rls/ \
    ; done \
    && CGO_ENABLED=0 \
        EXTRA_LDFLAGS='-extldflags "-static"' \
        go run build.go \
            -no-upgrade \
            -goos windows \
            -goarch 386 \
             zip \
    && mv syncthing-*.zip /rls/ \
    && ls -al /rls


## separate step for "all" again
#RUN cd syncthing \
#    && echo "building windows:all" \
#        CGO_ENABLED=0 \
#        EXTRA_LDFLAGS='-extldflags "-static"' \
#        go run build.go \
#            -no-upgrade \
#            -goos windows \
#            -goarch 386 \
#             build all \
#        ; done \
#    && for tgt in $TGTS2; do \
#        ls -al $tgt.exe \
#        && mv $tgt.exe /rls/ \
#    ; done


RUN cd syncthing \
    && echo "building linux:all-subset" \
    && for tgt in $TGTS2; do \
        echo "building linux:$tgt" \
        && (cd cmd/$tgt \
            && CGO_ENABLED=0 \
                GOOS=windows \
                GOARCH=386 \
                go build \
                    -ldflags '-extldflags "-static"' \
                    -tags noupgrade \
        ); done

RUN cd syncthing \
    && for tgt in $TGTS2; do \
        (cd cmd/$tgt \
        && ls -al $tgt.exe \
        && mv $tgt.exe /rls/ \
    ); done






# v1
#   26154547 bytes elf
#   23761336 bytes elf stripped
# v2, no-upgrade
#   25976181 bytes elf
#   23595928 bytes elf stripped
#
# avoid these:
#   Using discovery server https://discovery.syncthing.net/v2/?noannounce&id=
#   Using discovery server https://discovery-v4.syncthing.net/v2/?nolookup&id=
#   Joined relay relay://54.38.134.38:22067
#   quic://0.0.0.0:22000 resolved external address quic://x.x.x.x:13860 (via stun.syncthing.net:3478)
#
# relevant configs:
#   GlobalAnnEnabled        bool     `xml:"globalAnnounceEnabled" json:"globalAnnounceEnabled" default:"true" restart:"true"`
#   RelaysEnabled           bool     `xml:"relaysEnabled" json:"relaysEnabled" default:"true"`
#   StartBrowser            bool     `xml:"startBrowser" json:"startBrowser" default:"true"`
#   CREnabled               bool     `xml:"crashReportingEnabled" json:"crashReportingEnabled" default:"true" restart:"true"`
#   NATEnabled              bool     `xml:"natEnabled" json:"natEnabled" default:"true"`
#   URAccepted              int      `xml:"urAccepted" json:"urAccepted"`
#
# rm -rf ~/.config/syncthing/
