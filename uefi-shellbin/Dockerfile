FROM alpine:latest
MAINTAINER ed <uefi.shellbin@ocv.me>
WORKDIR /z

ENV VER="202308"

RUN apk add --no-cache gcc g++ musl-dev make git patch \
        bash nasm util-linux-dev util-linux-misc python3 \
        xorriso dosfstools mtools \
    && mkdir edk2 \
    && cd edk2 \
    && git init \
    && git remote add origin https://github.com/tianocore/edk2 \
    && git fetch --depth=1 origin edk2-stable$VER \
    && git reset --hard FETCH_HEAD \
    && git submodule init \
    && git submodule update

COPY p1.sh .
RUN bash p1.sh

COPY terse.patch .
RUN cd edk2 && dos2unix ShellPkg/Application/Shell/Shell.uni && patch -p1 </z/terse.patch

#COPY noscroll.patch .
#RUN cd edk2 && dos2unix ShellPkg/Application/Shell/ConsoleLogger.c && patch -p1 </z/noscroll.patch

COPY dmpstore-yolo.patch .
RUN cd edk2 && dos2unix ShellPkg/Library/UefiShellDebug1CommandsLib/DmpStore.c && patch -p1 </z/dmpstore-yolo.patch

COPY p2.sh .
RUN bash p2.sh

COPY mkiso.sh .
RUN bash mkiso.sh
