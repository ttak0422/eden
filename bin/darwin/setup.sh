#!/usr/bin/env bash

[[ ! $(which arch) ]] && sudo softwareupdate --install-rosetta --agree-to-license
exit 0
