prefix=/usr/local

all: help

help:
	@echo "Nothing really to make, but there are some available commands:"
	@echo " * install  : install application to $(prefix)"
	@echo " * check    : run static checks"
	@echo " * test     : run dynamic tests"
	@echo " * style    : style bash script"
	@echo " * feedback : create a GitHub issue"

install:
	@echo "Hint: consider to use 'brew install AlexanderWillner/tap/counterpart' instead"
	@install -m 0755 counterpart $(prefix)/bin

feedback:
	@open https://github.com/alexanderwillner/counterpart/issues

check:
	@type shellcheck >/dev/null 2>&1 || (echo "Run 'brew install shellcheck' first." >&2 ; exit 1)
	@echo "Running shell checks..."
	@shellcheck -x counterpart

test:
	@type shunit2 >/dev/null 2>&1 || (echo "Run 'brew install shunit2' first." >&2 ; exit 1)
	@echo "Running unit tests..."
	@shunit2 counterpartTest

style:
	@type shfmt >/dev/null 2>&1 || (echo "Run 'go get -u mvdan.cc/sh/cmd/shfmt' first." >&2 ; exit 1)
	@shfmt -i 2 -w -s *.sh


.PHONY: install feedback test style check
