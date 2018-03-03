prefix=/usr/local

all: help

help:
	@echo "Nothing really to make, but there are some available commands:"
	@echo " * install  : install application to $(prefix)"
	@echo " * test     : run some tests"
	@echo " * style    : style bash script"
	@echo " * feedback : create a GitHub issue"

install:
	@echo "Hint: consider to use 'brew install AlexanderWillner/tap/counterpart' instead"
	@install -m 0755 counterpart $(prefix)/bin

feedback:
	@open https://github.com/alexanderwillner/counterpart/issues

test: check
	@echo "Running shell checks..."
	@shellcheck -x *.sh
	@echo "Running unit tests..."

style:
	@type shfmt >/dev/null 2>&1 || (echo "Run 'go get -u mvdan.cc/sh/cmd/shfmt' first." >&2 ; exit 1)
	@shfmt -i 2 -w -s *.sh

check:
	@type shellcheck >/dev/null 2>&1 || (echo "Run 'brew install shellcheck' first." >&2 ; exit 1)

.PHONY: install feedback test style check
