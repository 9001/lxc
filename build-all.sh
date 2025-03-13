#!/bin/bash
set -e

# skipping these:
#   gentoo-native

[ -e uefi-shellbin ] && [ -e bndl.sh ] &&
    find -type d -name rls -exec rm -rf '{}' +

for d in static-* uefi-shellbin ; do
    #        cfssl: OK, but official builds are smaller
    #    ext4magic: unmaintained (still works)
    #  imagemagick: unmaintained (not very useful)
    #          mpv: unmaintained (hella busted)
    #     quickbms: unmaintained (not very useful, saves 5.4 MiB)
    #        quiet: unmaintained (the upstream is)
    #        sshfs: unmaintained (still works)
    #    syncthing: unmaintained (still works?)
    #        unrar: illegal; do this instead: bsdtar xf file.rar
    echo $d | grep -qE '.-(cfssl|ext4magic|imagemagick|quickbms|quiet|syncthing|unrar)$' && continue
    printf '\033]0;%s\033\\\n\033[7m[ %s ]\033[0m\n\n' "$d" "$d"
    pushd $d
    make
    popd
done

printf '\033]0;\033\\'
./bndl.sh
