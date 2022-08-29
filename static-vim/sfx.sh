#!/bin/bash
set -e

_sfx_name=foo
_sfx_dir="$(
	printf '%s\n' "$TMPDIR" /tmp |
	awk '/./ {print;exit}'
)/pe-$_sfx_name.$$"

# usage: ./sfx.sh create_sfx $PKG_NAME

(
sfxid=foo
dec1=pixz; dec2=J; comp1=(pixz -7k); comp2=(xz -cze7T0)  # 3.5m 0.3s
dec1=pigz; dec2=z; comp1=(pigz -11 -cI 100); comp2=(gzip -c)  # 4.3m 0.1s

[ "$1" = "create_sfx" ] && {
	sfxid=$(printf %s_%s $(date +%s) $$)
	
	command -v ${comp1[0]} >/dev/null &&
		comp="${comp1[*]}" ||
		comp="${comp2[*]}"
	
	out=../$2.sfx
	echo packing $out
	time (
		sed -r "s/^(sfxid=).*/\1$sfxid/; s/^(_sfx_name=).*/\1$2/" < "$0"
		echo "sfx_eof"
		
		find -not -type d |
		LC_ALL=C sort |
		tee /dev/stderr |
		tar -cT- --numeric-owner --owner=1000 --group=1000 |
		$comp
	) > $out
	chmod 755 $out
	printf '\ncreated %s\n' "$(realpath $out)"
	exit 234
}

[ -e "${_sfx_dir%.*}/.sfx.$sfxid" ] || (
	printf '\033[0;36munpacking\033[1;30m\n'
	mkdir -p "$_sfx_dir"
	ln=$(
		awk '$0=="sfx_eof" {print NR+1; exit}' < "$0"
	)
	
	[ "$ln" = "" ] && {
		printf '\033[0mcould not find SFX boundary, aborting\n'
		exit 1
	}
	
	command -v $dec1 >/dev/null &&
		dec=I$dec1 ||
		dec=$dec2
	
	tail -n +$ln "$0" |
	tar -$dec -xC "$_sfx_dir"
	
	printf '\033[0m'
	
	ln -nsf "$_sfx_dir" "${_sfx_dir%.*}"
	
	now=$(date -u +%s)
	for d in "${_sfx_dir%.*}".*; do
		ts=$(stat -c%Y -- "$d")
		[ $((now-ts)) -gt 300 ] &&
			flock -n "$d" rm -rf "$d" || true
	done
	touch "$_sfx_dir/.sfx.$sfxid"

	(echo "x /tmp/pe-*" > /run/tmpfiles.d/pe.conf) 2>/dev/null || true  # thx systemd
) >&2
) || {
	[ $? -eq 234 ]
	exit
}

[ -e "$_sfx_dir" ] ||
	_sfx_dir="$(readlink "${_sfx_dir%.*}" || echo "${_sfx_dir%.*}")"

flock "$_sfx_dir" sleep 2147483646 &  # thx systemd

"$_sfx_dir"/run.sh "$0" "$@" && rv=0 || rv=$?

kill $(jobs -p) 2>/dev/null || true
exit $rv
