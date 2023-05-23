#!/bin/bash
set -e

ln -s /usr/bin/python3 /usr/bin/python || true

cd edk2
make -j$(nproc) -C BaseTools
