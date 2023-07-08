#!/usr/bin/env bash

readonly ONEDRIVE_DIR="$HOME/OneDrive"

function fail() {
  echo "$1" >&2
  exit 1
}

[[ ! -d $ONEDRIVE_DIR ]] && fail "OneDrive directory not found: $ONEDRIVE_DIR"

[[ ! -d "$HOME/org" ]] && ln -s "$ONEDRIVE_DIR/org" "$HOME/org"
[[ ! -d "$HOME/neorg" ]] && ln -s "$ONEDRIVE_DIR/neorg" "$HOME/neorg"
[[ ! -d "$HOME/vault" ]] && ln -s "$ONEDRIVE_DIR/vault" "$HOME/vault"

exit 0
