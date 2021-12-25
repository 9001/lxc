# now resume the mpv-build that we split up
RUN export LC_ALL=C \
    && cd mpv-build \
    && ./build
#    && ./build || { printf '\033[33m'; find /tmp/pe-mpv | grep ffbuild/config.log | xargs cat; exit 1; }

# include gpl'd source code & ensure build is actually free
RUN mkdir -p /rls/src \
    && cp -pv /tmp/pe-mpv/src-gpl.txz /rls/src/gpl.txz \
    && /tmp/pe-mpv/src/mpv-build/ffmpeg_build/ffmpeg -version | \
    awk '/^configuration: /&&!/--enable-nonfree/ {ok=1} END {if (!ok) {exit 1}}'

# and the config logs
RUN find -iname config.log | sort | tar -cT- | xz -cze9T0 > /rls/src/config.txz


# # look for system libraries replicated in local
# cd /tmp/pe-mpv && LD_LIBRARY_PATH=. ldd mpv | sed -r 's`.* => *``;s` .*``' | grep lib64 | sed -r 's`.*/``' | while IFS= read -r x; do find -name "$x"; done 
#
# # look for local libraries replicated on system
# find /usr | grep -F /lib > /dev/shm/libs; cd /tmp/pe-mpv && LD_LIBRARY_PATH=. ldd mpv | sed -r 's`.* => *``;s` .*``' | grep -v lib64 | sed -r 's`.*/``' | while IFS= read -r x; do grep -F -- "$x" /dev/shm/libs; done 2>/dev/null
#
# # and compare sizes
# find /usr | grep -F /lib > /dev/shm/libs; cd /tmp/pe-mpv && LD_LIBRARY_PATH=. ldd mpv | sed -r 's`.* => *``;s` .*``' | grep -v lib64 | sed -r 's`.*/``' | while IFS= read -r x; do grep -F -- "$x" /dev/shm/libs | while IFS= read -r y; do ls -Hal "$x" "$y"; echo; done; done 2>/dev/null 
