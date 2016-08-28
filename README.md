# [erlang-formatter](https://github.com/fenollp/erlang-formatter) [![Build Status](https://travis-ci.org/fenollp/erlang-formatter.svg?branch=master)](https://travis-ci.org/fenollp/erlang-formatter)

Format Erlang code "to the standard": using Emacs' [erlang-mode](http://erlang.org/doc/man/erlang.el.html).

Used daily in CI at [Kazoo](https://github.com/2600Hz/Kazoo) to ensure coding style.

## Dependencies

* emacs24

## Notes

Alternatives to this dependency-heavy utility:

* For Vim users [this](http://erlang.org/pipermail/erlang-questions/2009-February/041719.html) can [help](http://stackoverflow.com/questions/4085411/vim-indent-like-emacs)
* [erl_tidy](http://erlang.org/doc/man/erl_tidy.html)

## To do

1. less verbose on no errors
1. add newline to end of file when missing
1. make it faster
1. ensure it respects file-local settings like `%% -*- erlang-indent-level: 2; indent-tabs-mode: nil -*-`
1. option handling to disable default TABs policy (default: spaces only)
    * Reminiscent of `Just like the CAP theorem, I posit the TIA theorem: tabs, indentation, alignment, choose two.` -- Loïc Hoguin
1. write a rebar3 plugin
1. maybe: do not depend on Emacs

## Bugs uncovered with this project

1. [ERL-204](https://bugs.erlang.org/browse/ERL-204)
1. [ERL-210](https://bugs.erlang.org/browse/ERL-210)
1. [ERL-212](https://bugs.erlang.org/browse/ERL-212)
1. [ERL-228](https://bugs.erlang.org/browse/ERL-228)

Feel free to [report issues encountered with this tool](https://github.com/fenollp/erlang-formatter/issues).
I will minify & report them.
