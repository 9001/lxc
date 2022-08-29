#!/bin/bash
set -e

_sfx_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/bin"
_sfx_bp="$_sfx_dir/${1##*/}"
[ -e "$_sfx_bp" ] ||
    _sfx_bp="$_sfx_dir/vim"

shift

PATH="$_sfx_dir:$PATH" \
exec "$_sfx_bp" "$@"
