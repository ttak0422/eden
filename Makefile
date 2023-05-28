.DEFAULT_GOAL := eden

.PHONY: eden
eden:
	@echo "eden (vX.X.X - WIP)"

.PHONY: setup_develop
setup_develop:
ifeq ($(OS),Windows_NT)
	@echo "setup develop for Windows."
	@echo "wip..."
else
	@echo "setup develop for Linux, MacOS."
	@./bin/xnix/setup_develop.sh
endif

.PHONY: setup
setup:
	"${MAKE}" setup_develop
