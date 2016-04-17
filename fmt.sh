#!/bin/bash

# Format Erlang code using Emacs' erlang-mode from github.com/erlang/otp

curdir="$(dirname "$0")"

EMACS=${EMACS:-emacs}
ERLANGEL="${ERLANGEL:-$curdir/emacs}"

echo .$ERLANGEL.

$EMACS --batch --quick --directory "$ERLANGEL" --load "$curdir"/fmt.el $*
