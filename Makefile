.PHONY: all test goldies compile shellcheck update

branch = master
root = https://raw.githubusercontent.com/erlang/otp/$(branch)
erlang = $(root)/lib/tools/emacs/erlang.el
erlangstart = $(root)/lib/tools/emacs/erlang-start.el

REBAR3 ?= rebar3
SHELLCHECK ?= docker run --rm -v $(PWD):$(PWD) -w $(PWD) koalaman/shellcheck-alpine shellcheck

all:
	curl -o priv/erlang.el $(erlang)
	curl -o priv/erlang-start.el $(erlangstart)
	git --no-pager diff --exit-code

test: goldies compile shellcheck update

goldies:
	./fmt.sh test/before
	cp -a test/before/* test/after
	git checkout -- test/before
	bash -c "! git grep -l $$'\t' -- test/after"
	git --no-pager diff --exit-code -- test/after

compile:
	$(REBAR3) compile

shellcheck:
	$(SHELLCHECK) *.sh

update:
	$(REBAR3) do update, upgrade --all
	$(REBAR3) plugins upgrade --all
	$(REBAR3) unlock --all && $(REBAR3) lock
