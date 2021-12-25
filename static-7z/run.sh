#!/bin/bash
set -e

_sfx_self="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

PATH="$_sfx_self/env/bin:$PATH" \
exec "$_sfx_self/"7za "$@"
