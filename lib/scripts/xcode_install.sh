#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
# Installs XCode

if ! xcode-select -p; then
  xcode-select --install
else
  printf 'xcode already installed, nothing to do.'
fi
