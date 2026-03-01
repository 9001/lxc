#!/bin/bash
set -ex
rm -rf bin bin*.sfx
mkdir bin
cp -pv */rls/* bin/ || true
cp -pvR static-pico2wave/rls/pico2wave-voices bin/ || true
#tar -cv bin | zstd --long -T0 -19 > bin.tzst
bin/7z a -sfx -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on bin-full.sfx bin

(cd bin
rm flite cmu_us_slt.*
rm clzip lunzip lzd lzip plzip tarlz zcat zcmp zdiff zgrep ztest zupdate
rm bsdcpio bsdunzip
rm pico2wave-voices/{de,es,fr,it,en-US}*
)
bin/7z a -sfx -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on bin.sfx bin

chmod 755 bin*.sfx
cat <<'EOF'

  created bin.sfx which can be executed to spawn the bin folder anywhere
EOF
