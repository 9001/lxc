#!/bin/bash
set -e

ptn='(^|[^a-zA-Z0-9])(sha512_224_init|sha512_256_init|poly1305_init)'

grep -lRE "$ptn" |
while IFS= read -r x; do
	sed -ri "s/$ptn/"'\1\2_tc/g' "$x";
done
