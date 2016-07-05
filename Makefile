.PHONY: all test

all:
	wget -O emacs/erlang.el 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang.el'
	wget -O emacs/erlang-skels.el 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-skels.el'
	wget -O emacs/erlang-start.el 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-start.el'

test:
	./fmt.sh $(wildcard test/*.erl)
	bash -c '[[ 3 -eq $$(git status --porcelain test/ | wc -l) ]]'
	git checkout -- test
