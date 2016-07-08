.PHONY: all test

erlang = 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang.el'
erlangskels = 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-skels.el'
erlangstart = 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-start.el'

all:
	curl -o emacs/erlang.el $(erlang)
	curl -o emacs/erlang-skels.el $(erlangskels)
	curl -o emacs/erlang-start.el $(erlangstart)

test:
	./fmt.sh test/
	bash -c '[[ 3 -eq $$(git status --porcelain test/ | wc -l) ]]'
	git checkout -- test
