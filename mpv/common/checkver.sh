#!/bin/bash
set -e
mkdir -p /dev/shm/t.checkver
cd /dev/shm/t.checkver

[ -e nasm  ] || wget -O nasm  https://www.nasm.us/
[ -e yasm  ] || wget -O yasm  https://yasm.tortall.net/Download.html
[ -e lame  ] || wget -O lame  http://lame.sourceforge.net/
[ -e opus  ] || wget -O opus  http://opus-codec.org/downloads/
[ -e xiph  ] || wget -O xiph  https://xiph.org/downloads/
[ -e vpx   ] || wget -O vpx   https://github.com/webmproject/libvpx/tags
[ -e vdpau ] || wget -O vdpau https://gitlab.freedesktop.org/vdpau/libvdpau/tags
[ -e vmaf  ] || wget -O vmaf  https://github.com/Netflix/vmaf/releases
[ -e vulkh ] || wget -O vulkh https://github.com/KhronosGroup/Vulkan-Headers/tags
[ -e libva ] || wget -O libva https://github.com/intel/libva/releases
[ -e intva ] || wget -O intva https://github.com/intel/intel-vaapi-driver/releases
[ -e meson ] || wget -O meson https://github.com/mesonbuild/meson/releases

xiph() {
	label=$1
	needle=$2
	perl -ne '
		if (/<th>Stable Version<\/th>/) {$a=1}
		if (/<\/table>/) {$a=0}
		if ($a==1 && /<td>'$needle'<\/td>/) {$n=2}
		if ($n==1 && /<td>([^<]+)<\/td>/) {print "VER_'$label'=$1 \\\n"};
		if ($n>0) {$n--}' xiph
}

# note: lines with additional indentation means the previous check failed

echo -ne "ENV "; perl -ne 'if (/<th scope="row">Stable<\/th>/) {$n=2} if ($n==1 && /">([^<>]+)<\/a><\/td>/) {print "VER_NASM=$1 \\\n"}; if ($n>0) {$n--}' nasm
echo -ne "    "; perl -ne 'if (/<h1 id.*>Latest Release: ([^<]+)</) {print "VER_YASM=$1 \\\n"}' yasm
echo -ne "    "; perl -ne 'if (/Latest LAME release: <a href="download.php">v([^<]+)</) {print "VER_LAME=$1 \\\n"}' lame
echo -ne "    "; perl -ne 'if (/ href="\/release\/stable\/[^">]*">libopus ([^<]*)<\/a><\/h3>/) {print "VER_OPUS=$1 \\\n"}' opus
echo -ne "    "; xiph LIBOGG    libogg
echo -ne "    "; xiph LIBVORBIS libvorbis
echo -ne "    "; xiph LIBTHEORA libtheora
echo -ne "    "; perl -ne 'if (!/-rc/ && / href="\/webmproject\/libvpx\/releases\/tag\/v([^\/"]+)/) {print "VER_LIBVPX=$1 \\\n";exit}' vpx
echo -ne "    "; perl -ne 'if (/ href="\/vdpau\/libvdpau\/-\/tags\/(libvdpau-)?([0-9\.]+)/) {print "VER_LIBVDPAU=$2 \\\n";exit}' vdpau
echo -ne "    "; perl -ne 'if (/ href="\/Netflix\/vmaf\/releases\/tag\/([^\/"]+)/) {print "VER_VMAF=$1 \\\n";exit}' vmaf
#echo -ne "    "; perl -ne 'if (/ href="\/KhronosGroup\/Vulkan-Headers\/releases\/tag\/v([^\/"]+)/) {print "VER_VULKAN_HEADERS=$1 \\\n";exit}' vulkh
echo -ne "    "; perl -ne 'if (/ href="\/KhronosGroup\/Vulkan-Headers\/releases\/tag\/sdk-([^\/"]+)"/) {print "VER_VULKAN_HEADERS=$1 \\\n";exit}' vulkh
echo -ne "    "; perl -ne 'if (/ href="\/intel\/libva\/releases\/tag\/([^\/"]+)/) {print "VER_LIBVA=$1 \\\n";exit}' libva
echo -ne "    "; perl -ne 'if (/ href="\/intel\/intel-vaapi-driver\/releases\/tag\/([^\/"]+)/) {print "VER_INTEL_VAAPI_DRIVER=$1 \\\n";exit}' intva
echo -ne "    "; perl -ne 'if (/ href="\/mesonbuild\/meson\/releases\/tag\/([^\/"]+)/) {print "VER_MESON=$1 \\\n";exit}' meson
