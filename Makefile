.PHONY: all test

branch = master
root = https://raw.githubusercontent.com/erlang/otp/$(branch)
erlang = $(root)/lib/tools/emacs/erlang.el
erlangstart = $(root)/lib/tools/emacs/erlang-start.el

all:
	curl -o priv/erlang.el $(erlang)
	curl -o priv/erlang-start.el $(erlangstart)
	git --no-pager diff
	bash -c '[[ 0 -eq $$(git --no-pager diff --name-only | wc -l) ]]'

test: SHELLCHECK ?= shellcheck
test:
	./fmt.sh test/before
	cp -a test/before/* test/after
	git checkout -- test/before
	git --no-pager diff -- test/after
	bash -c "! git grep -l $$'\t' -- test/after"
	bash -c '[[ 0 -eq $$(git status --porcelain test/after | wc -l) ]]'
	rebar3 compile
	$(SHELLCHECK) *.sh
