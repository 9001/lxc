#!/bin/bash
set -e

# skipping these:
#   gentoo-native

for d in static-* sshfs-* mpv; do
    printf '\033]0;%s\033\\\n\033[7m[ %s ]\033[0m\n\n' "$d" "$d"
    pushd $d
    make
    popd
done

printf '\033]0;\033\\'
