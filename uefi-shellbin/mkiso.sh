#!/bin/bash
set -e

# mostly untested, seems to work in VMs --
# cp -pv /usr/share/OVMF/OVMF_{CODE,VARS}.fd . && qemu-system-x86_64 -cpu host -enable-kvm -cdrom rls/efishell.iso -drive file=OVMF_CODE.fd,format=raw,if=pflash -drive file=OVMF_VARS.fd,format=raw,if=pflash -m 512

mkdir -p espdir/efi/boot
cp -pv /rls/Shell.efi espdir/efi/boot/bootx64.efi

sz=$(wc -c </rls/Shell.efi | awk '{print int($1/1024)+256}')
touch esp
truncate -s ${sz}k esp
mkfs.vfat -F12 -nESP esp
mcopy -i esp -s espdir/* ::
mv esp espdir/

xorrisofs -V EFISHELL -l -J -R -eltorito-alt-boot -e esp -no-emul-boot -isohybrid-gpt-basdat -o /rls/efishell.iso ./espdir
