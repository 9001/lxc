FROM rockylinux/rockylinux:8
MAINTAINER ed <el-sfx@ocv.me>

WORKDIR /z

ENV VER="3.7.2" \
    SHA="1612d515869a8b38c0bc3d79eaf80e8b4da1a9710c9668e6ec23e6b77313063ae0bee66ab9e9e0f70d98eaa1334425b2087dd93cc4618af3ac6ac191acf7f838"

RUN yum -y install fuse3 fuse3-devel python3 gcc glib2-devel xz \
    && python3 -m pip install meson ninja docutils

RUN curl -LO https://github.com/libfuse/sshfs/releases/download/sshfs-$VER/sshfs-$VER.tar.xz \
    && echo "$SHA  sshfs-$VER.tar.xz" | sha512sum -c \
    && tar -xvf sshfs-$VER.tar.xz

RUN cd sshfs-$VER/ \
    && mkdir build \
    && cd build \
    && meson --prefix=/tmp/pe-sshfs .. \
    && ninja install
# DESTDIR=/z/pkg/sshfs ninja install

RUN cd /tmp/pe-sshfs/bin \
    && strip sshfs
