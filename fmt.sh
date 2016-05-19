#!/bin/bash

# Format Erlang code using Emacs' erlang-mode from github.com/erlang/otp

[[ $# -eq 0 ]] && echo "Usage: $0  <path to .erl or folder>+" && exit 1

curdir="$(dirname "$0")"

EMACS=${EMACS:-emacs}
ERLANGEL="${ERLANGEL:-$curdir/emacs}"
VSN=$("$EMACS" --version | head -n 1 | grep -Eo '2[0-9]')

function format() {
    "$EMACS" --batch --quick --directory "$ERLANGEL" --load "$curdir"/fmt.el $*
}

while [[ "$1" != '' ]]; do
    if [[ -d "$1" ]]; then
        format $(find "$1" -name *.erl)
    else
        format "$1"
    fi
    shift
done
