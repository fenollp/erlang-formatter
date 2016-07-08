.PHONY: all test

erlang = 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang.el'
erlangskels = 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-skels.el'
erlangstart = 'https://raw.githubusercontent.com/erlang/otp/maint/lib/tools/emacs/erlang-start.el'

all:
	curl -o emacs/erlang.el $(erlang)
	curl -o emacs/erlang-skels.el $(erlangskels)
	curl -o emacs/erlang-start.el $(erlangstart)

test:
	./fmt.sh test/before
	cp -a test/before/*.?rl test/after
	bash -c '[[ 4 -eq $$(git status --porcelain test/after | wc -l) ]]'
	git checkout -- test/before
