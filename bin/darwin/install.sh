#!/usr/bin/env bash

# rosetta
[[ ! $(which arch) ]] && sudo softwareupdate --install-rosetta --agree-to-license

# homebrew
[[ ! $(which brew) -o ! -d /opt/homebrew/bin/brew ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

exit 0
