# [erlang-formatter](https://github.com/fenollp/erlang-formatter) [![Build Status](https://travis-ci.org/fenollp/erlang-formatter.svg?branch=master)](https://travis-ci.org/fenollp/erlang-formatter/builds)

Format Erlang code "to the standard": using Emacs' [erlang-mode](http://erlang.org/doc/man/erlang.el.html).

Used daily in CI on [2600Hz's Kazoo](https://github.com/2600Hz/Kazoo) project à la `gofmt`.

## Using as a `rebar3` plugin

Add the plugin to your rebar config:

```erlang
{plugins, [rebar3_fmt]}.
```

Then just call your plugin directly in an existing application:

```shell
$ rebar3 fmt
```

## Using `make`

```make
.PHONY: fmt
FMT = _build/erlang-formatter-master/fmt.sh
$(FMT):
	mkdir -p _build/
	curl -f#SL 'https://codeload.github.com/fenollp/erlang-formatter/tar.gz/master' | tar xvz -C _build/

# Pick either this one to go through the whole project
fmt: TO_FMT ?= .
# Or this faster, incremental pass
#fmt: TO_FMT ?= $(shell git --no-pager diff --name-only HEAD origin/master -- '*.app.src' '*.config' '*.config.script' '*.erl' '*.escript' '*.hrl')

fmt: $(FMT)
	$(if $(TO_FMT), $(FMT) $(TO_FMT))
# Example:
#   TO_FMT='src/a.erl include/b/hrl' make fmt
```

## Dependencies

* emacs ≥ 24

## Notes

Some alternatives (in no particular order) to this dependency-heavy utility:

* For Vim users [this](http://erlang.org/pipermail/erlang-questions/2009-February/041719.html) can [help](http://stackoverflow.com/questions/4085411/vim-indent-like-emacs)
* [erl_tidy](./test/before/erl_tidy.escript)
* [vim-erlang-runtime](https://github.com/vim-erlang/vim-erlang-runtime)
* [erlang_stdin_formatter](https://github.com/ebengt/erlang_stdin_formatter)
* [erlang_string_io](https://github.com/ebengt/erlang_string_io)
* [sourcer](https://github.com/erlang/sourcer/pull/10)
* [erl_tidy](https://github.com/tsloughter/erl_tidy)

## To do

1. less verbose on no errors
1. add newline to end of file when missing
1. make it faster
1. ensure it respects file-local settings like `%% -*- erlang-indent-level: 2; indent-tabs-mode: nil -*-`
1. option handling to disable default TABs policy (default: spaces only)
    * Reminiscent of `Just like the CAP theorem, I posit the TIA theorem: tabs, indentation, alignment, choose two.` -- Loïc Hoguin
1. maybe: do not depend on Emacs

More at https://github.com/fenollp/erlang-formatter/issues

## Bugs uncovered with this project

1. [ERL-204: `$ embedded at the end of a string causes wrong indentation`](https://bugs.erlang.org/browse/ERL-204)
1. [ERL-210: `{} inside multiline strings are indented`](https://bugs.erlang.org/browse/ERL-210)
1. [ERL-212: `Linebreak after fun but before ( breaks indentation`](https://bugs.erlang.org/browse/ERL-212)
1. [ERL-228: `Defining type as a tuple containing a fun() followed by expression throws Emacs error`](https://bugs.erlang.org/browse/ERL-228)
1. [ERL-526: `Binary in a multiline list comprehension nests wrongly`](https://bugs.erlang.org/browse/ERL-526)

Feel free to [report issues encountered with this tool](https://github.com/fenollp/erlang-formatter/issues).
I will minify & report them.
