.PHONY: all test

all:
	curl -o emacs/erlang.el 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang.el'
	curl -o emacs/erlang-skels.el 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-skels.el'
	curl -o emacs/erlang-start.el 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-start.el'

test:
	./fmt.sh $(wildcard test/*.erl)
	bash -c '[[ 3 -eq $$(git status --porcelain test/ | wc -l) ]]'
	git checkout -- test
