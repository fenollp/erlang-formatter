# [erlang-formatter](https://github.com/fenollp/erlang-formatter) [![Build Status](https://travis-ci.org/fenollp/erlang-formatter.svg?branch=master)](https://travis-ci.org/fenollp/erlang-formatter)

Format Erlang code using Emacs' [erlang-mode](http://erlang.org/doc/man/erlang.el.html)

## Dependencies

* emacs24

## To do

1. make it faster
1. ensure it respects per-file settings like `%% -*- erlang-indent-level: 2; indent-tabs-mode: nil -*-`
1. option handling to disable default TABs policy (default: spaces only)
1. write a rebar3 plugin
1. maybe: do not depend on Emacs

## Bugs uncovered with this project

1. [ERL-204](https://bugs.erlang.org/browse/ERL-204)
1. [ERL-210](https://bugs.erlang.org/browse/ERL-210)
1. [ERL-212](https://bugs.erlang.org/browse/ERL-212)
