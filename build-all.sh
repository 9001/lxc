#!/bin/bash
set -e

# skipping these:
#   gentoo-native

for d in static-* uefi-shellbin ; do
    #        cfssl: OK, but official builds are smaller
    #    ext4magic: unmaintained (still works)
    #          mpv: unmaintained (hella busted)
    #        quiet: unmaintained (the upstream is)
    #        sshfs: unmaintained (still works)
    #    syncthing: unmaintained (still works?)
    echo $d | grep -qE '.-(cfssl|ext4magic|quiet|syncthing)$' && continue
    printf '\033]0;%s\033\\\n\033[7m[ %s ]\033[0m\n\n' "$d" "$d"
    pushd $d
    make
    popd
done

printf '\033]0;\033\\'
./bndl.sh
