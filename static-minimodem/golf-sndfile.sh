#!/bin/ash
set -e
(cd src; rm -rf ALAC G72x GSM610 alac.c avr.c caf.c dwd.c flac.c g72x.c gsm610.c htk.c ircam.c mat4.c mat5.c mpc2k.c mpeg* nist.c ogg* paf.c pvf.c rx2.c sd2.c sds.c svx.c )
sed -ri '/src\/(ALAC|G72x|GSM610|alac|avr|caf|dwd|flac|g72x|gsm610|htk|ircam|mat4|mat5|mpc2k|mpeg|nist|ogg|paf|pvf|rx2|sd2|sds|svx)/d' CMakeLists.txt
awk '/# g72x_test/{s=1}!s;/PROPERTIES FOLDER Tests/{s=0}' <CMakeLists.txt >a && mv a CMakeLists.txt
sed -ri '/error = (paf|svx|nist|ircam|vox|sds|ogg|txw|wve|dwd|mat4|mat5|pvf|xi|htk|sd2|rx2|avr|flac|caf|mpc2k|mpeg)_open /d' src/sndfile.c
for f in aiff au raw w64 wav; do sed -ri '/error = (gsm610|g72x|mpeg)_init /d' src/$f.c ;done
