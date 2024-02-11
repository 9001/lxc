#!/bin/bash
set -e

cd edk2
. edksetup.sh

sed -ri 's/(.*\.ShellInitSettings\.BitUnion\.Bits\.NoMap *= *)FALSE/\1TRUE/' ShellPkg/Application/Shell/Shell.c

# PcdShellDefaultDelay: num sec countdown before startup.nsh is executed
# PcdShellScreenLogCount: num screens of scrollback; >= 1
# PcdShellSupplier: banner text
args=(
    --pcd gEfiShellPkgTokenSpaceGuid.PcdShellDefaultDelay=1
    --pcd gEfiShellPkgTokenSpaceGuid.PcdShellScreenLogCount=8
    --pcd gEfiShellPkgTokenSpaceGuid.PcdShellSupplier=a
)

[ -e /z/noscroll.patch ] && args+=(
    --pcd gEfiShellPkgTokenSpaceGuid.PcdShellPageBreakDefault=TRUE
)

build -t GCC5 -a X64 -b RELEASE -p ShellPkg/ShellPkg.dsc "${args[@]}"

mkdir -p /rls
cp -pv Build/Shell/RELEASE_GCC5/X64/ShellPkg/Application/Shell/EA4BB293-2D7F-4456-A681-1F22F42CD0BC/OUTPUT/Shell.efi /rls/
