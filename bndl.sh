#!/bin/bash
set -ex
rm -rf bin
mkdir bin
cp -pv */rls/* bin/ || true
#tar -cv bin | zstd --long -T0 -19 > bin.tzst
bin/7z a -sfx -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on bin.sfx bin
cat <<'EOF'

  created bin.sfx which can be executed to spawn the bin folder anywhere
EOF
