# build scripts

everything here is unmaintained garbage but may serve as a reference on static builds or whatnot

PRs with updates / fixes / new stuff welcome


# important notes

* this repo relies on symlinks, so please either `git clone` or download as `.tar.gz`
    * don't download as `.zip` or unpack/repack on windows


# static builds

portable binaries built with musl, should run on all unixes (maybe even esxi)

| program | notes |
| -- | -- |
| [7z](./static-7z) | including the sfx plugin |
| [cfssl](./static-cfssl) | nothing special |
| [ext4magic](./static-ext4magic) | nothing special |
| [flite](./static-flite) | full build, and separate builds with just kal16 and slt |
| [imagemagick](./static-imagemagick) | fairly featurecomplete (freetype-brotli, fontconfig, tiff-zstd, png, webp, rsvg, xml, lcms), **but NOT:** gslib, heic |
| [jq](./static-jq) | nothing special |
| [lzip](./static-lzip) | and most of the side-projects |
| [minimodem](./static-minimodem) | no pulse or alsa; see `notes.txt` for how to stream pcm instead |
| [ntfs3g](./static-ntfs3g) | nothing special |
| [patchelf](./static-patchelf) | nothing special |
| [pigz](./static-pigz) | nothing special |
| [pixz](./static-pixz) | also provides `bsdtar` / `bsdcpio` / `bsdunzip` / `xz` |
| [pv](./static-pv) | nothing special |
| [quickbms](./static-quickbms) | 32bit due to funky pointer arithmetics |
| [quiet](./static-quiet) | with `fec` and hacks for unbounded pcm streaming and 48/96khz modes; see bottom of `Dockerfile` for usage |
| [rsync](./static-rsync) | with hacks (`musl.patch` and `rsync.patch`) to make it run fast on esxi (TODO check compat with regular rsync), and does NOT have iconv / ipv6 |
| [syncthing](./static-syncthing) | with modified defaults to discourage phoning home |
| [tar](./static-tar) | hella basic (32bit and no largefile/acl/nls) to support esxi |
| [tmux](./static-tmux) | nothing special |
| [unrar](./static-unrar) | nothing special |
| [xdelta3](./static-xdelta3) | nothing special |


# others

| program | notes |
| -- | -- |
| [uefi-shell](./uefi-shellbin) | shell.efi with some QoL hacks |
| [mpv](./mpv) | very feature-complete build of mpv and ffmpeg, including hw-accel, for centos7/8 and debian |
| [sshfs-c8](./sshfs-c8) | sshfs v3.7.2 for centos8, with crashfixes etc since the official v2.8 |


# notes

i have entirely given up on these: `mpv`

and these too, but mainly because they're currently not very useful: `ext4magic`, `quiet`, `sshfs`, `syncthing`


# todo

ldd check is busted, `not a dynamic executable` and `Not a valid dynamic program` are also valid for static builds, think of something better
