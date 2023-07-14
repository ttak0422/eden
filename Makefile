.DEFAULT_GOAL := eden

.PHONY: eden
eden:
	@echo "eden"


#  _           _        _ _
# (_)_ __  ___| |_ __ _| | |
# | | '_ \/ __| __/ _` | | |
# | | | | \__ \ || (_| | | |
# |_|_| |_|___/\__\__,_|_|_|
#
.PHONY: install
install:
# Windows
ifeq ($(OS),Windows_NT)
	@echo "install for Windows."
# MacOS
else ifeq ($(shell uname),Darwin)
	@echo "install for MacOS."
	@./bin/darwin/install.sh
# Linux
else
	@echo "install for Linux."
endif


#           _
#  ___  ___| |_ _   _ _ __
# / __|/ _ \ __| | | | '_ \
# \__ \  __/ |_| |_| | |_) |
# |___/\___|\__|\__,_| .__/
#                    |_|
.PHONY: setup
setup:
# Windows
ifeq ($(OS),Windows_NT)
	@echo "setup develop for Windows."
	@echo "wip..."
# MacOS
else ifeq ($(shell uname),Darwin)
	@echo "setup develop for MacOS."
	@./bin/xnix/setup_develop.sh
	@./bin/xnix/setup_onedrive.sh
# Linux
else
	@echo "setup develop for Linux."
	@./bin/xnix/setup_develop.sh
	@./bin/xnix/setup_onedrive.sh
endif
