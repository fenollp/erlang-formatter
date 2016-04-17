.PHONY: test

test:
	./fmt.sh $(wildcard test/*.erl)
