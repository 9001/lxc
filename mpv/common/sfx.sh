#!/bin/bash
set -e

cachecmp=12,34                            # 163942400 byte,  0.000 sec
decompress="-zxvC"; compress="pigz -c"    #  61222856 byte,  6.055 sec
decompress="-JxvC"; compress="xz -cze7T0" #  46098091 byte, 19.456 sec
decompress="-JxvC"; compress="xz -cze8T0" #  28582754 byte, 34.685 sec
decompress="-JxvC"; compress="xz -cze9T0" #  19187817 byte, 55.483 sec
#decompress="-JxvC"; compress="xz -cz0T0"

gen_cachecmp() {
	find "$1" -type f -printf '%T@_%s\n' 2>/dev/null |
	sed -r 's/\.[^_]*//' |
	sort -n |
	tail -n 1
}

[ "$1" = create_sfx ] && {
	echo packing >&2
	time (
		sed -r "s/^(cachecmp=).*/\1$(gen_cachecmp rls)/; s/\\$\\{VARIANT\\}/$(basename "$(pwd)")/g" < "$0"
		echo "sfx_eof"
		cd rls
		
		find -type f |
		sort |
		tar -cT- |
		$compress
	) > mpv
	chmod 755 mpv
	echo created ./mpv >&2
	exit 0
}

dir="$(
	printf '%s\n' "$TMPDIR" /tmp |
	grep -vE '^$' |
	head -n 1
)/pe-mpv"

[ "$cachecmp" = "$(gen_cachecmp "$dir"/)" ] || (
	printf '\033[36munpacking for ${VARIANT}\033[1;30m\n'
	mkdir -p "$dir.$$"
	ln=$(
		awk '$0=="sfx_eof" {print NR+1; exit}' < "$0"
	)
	
	[ "$ln" = "" ] && {
		printf '\033[0mcould not find SFX boundary, aborting\n'
		exit 1
	}
	
	tail -n +$ln "$0" |
	tar $decompress "$dir.$$"
	
	printf '\033[0m'
	
	#mv "$dir" "$dir.$$.old" 2>/dev/null || true
	#mv -Tf "$dir.$$" "$dir" || {
	#	rm -rf "$dir".*
	#	false
	#}
	#rm -rf "$dir.$$.old" 2>/dev/null || true
	
	ln -nsf "$dir.$$" "$dir"
	
	now=$(date -u +%s)
	for d in "$dir".*; do
		ts=$(stat -c%Y -- "$d")
		[ $((now-ts)) -gt 300 ] &&
			rm -rf "$d" || true
	done
	
	[ -e "$dir/src/gpl.txz" ] && {
		printf '\033[36mGPL source code is available at %s\033[0m\n' "$dir/src/gpl.txz"
	}
	true
) >&2

elf=mpv
arg="$1"
for ep in ffmpeg ffplay ffprobe lame x264 x265
do
	[ "$arg" = "$ep" ] &&
		elf="$ep" && shift && break
done

LD_LIBRARY_PATH="$dir:$LD_LIBRARY_PATH:/usr/lib64/pulseaudio/" LIBVA_DRIVERS_PATH="$dir/dri" exec "$dir"/"$elf" "$@"

exit 0
