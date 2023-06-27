.DEFAULT_GOAL := eden

.PHONY: eden
eden:
	@echo "eden (vX.X.X - WIP)"

.PHONY: setup_develop
setup_develop:
ifeq ($(OS),Windows_NT)
	@echo "setup develop for Windows."
	@echo "wip..."
  ($(shell uname),Darwin)
else ifeq ($(shell uname),Darwin)
	@echo "setup develop for MacOS."
	@./bin/xnix/setup_develop.sh
	@./bin/darwin/setup.sh
else
	@echo "setup develop for Linux."
	@./bin/xnix/setup_develop.sh
endif

.PHONY: setup
setup:
	"${MAKE}" setup_develop
