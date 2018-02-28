#!/bin/bash

# Format Erlang code using Emacs' erlang-mode from github.com/erlang/otp

[[ $# -eq 0 ]] && echo "Usage: $0  <path to .erl or folder>+" && exit 1

curdir="$(dirname "$0")"

EMACS=${EMACS:-emacs}
ERLANGEL="${ERLANGEL:-$curdir/emacs}"

format() {
    $EMACS --batch --quick --directory "$ERLANGEL" --load "$curdir"/fmt.el "$@"
}

while [[ "$1" != '' ]]; do
    if [[ -d "$1" ]]; then
        # Note: test against compiled rebar3, jiffy.
        # TODO: actually fix this to support spaces in paths
        # shellcheck disable=SC2046
        format $(find "$1" \( -iname '*.app.src' \
                      -o      -iname '*.config' \
                      -o      -iname '*.config.script' \
                      -o      -iname '*.erl' \
                      -o      -iname '*.escript' \
                      -o      -iname '*.hrl' \
                      -o -type d -name .erlang.mk -prune \
                      -o -type d -name .eunit     -prune \
                      -o -type d -name .rebar     -prune \
                      -o -type d -name .rebar3    -prune \
                      -o -type d -name _build     -prune \
                      -o -type d -name _rel       -prune \
                      -o -type d -name deps       -prune \
                      -o -type d -name ebin       -prune \
                      \) \
                      -a -type f)
    elif [[ -e "$1" ]] && [[ "$1" =~ .+\.(app\.src|config|config\.script|erl|escript|hrl)$ ]]; then
        format "$1"
    fi
    shift
done
