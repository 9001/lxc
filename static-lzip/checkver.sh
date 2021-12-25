#!/bin/bash
set -e

while read url name key; do
	ver=$(curl -s "$url/$name/?C=M&O=A" | awk '/"[a-z]+-[0-9]\.[0-9]+\.tar\.lz"/{sub(/\.tar\.lz".*/,"");sub(/.*"[a-z]+-/,"");v=$0}END{print v}')
	sha=$(curl -s "$url/$name/$name-$ver.tar.lz" | sha512sum | awk '{print$1}')
	printf '%10s_%s="%s" \\\n' $key VER $ver $key SHA $sha
done < <(cat <<'EOF'
https://download-mirror.savannah.gnu.org/releases/lzip pdlzip PDLZIP
https://download-mirror.savannah.gnu.org/releases/lzip lzlib LZLIB
https://download-mirror.savannah.gnu.org/releases/lzip lzd LZD
https://download-mirror.savannah.gnu.org/releases      lzip LZIP
https://download-mirror.savannah.gnu.org/releases/lzip clzip CLZIP
https://download-mirror.savannah.gnu.org/releases/lzip plzip PLZIP
https://download-mirror.savannah.gnu.org/releases/lzip lunzip LUNZIP
https://download-mirror.savannah.gnu.org/releases      zutils ZUTILS
https://download-mirror.savannah.gnu.org/releases/lzip lziprecover LZRECO
https://download-mirror.savannah.gnu.org/releases/lzip tarlz TARLZ
EOF
)
