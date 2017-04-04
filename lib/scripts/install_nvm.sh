#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

# NVM adds its export to bashrc, but it's already in profile
git checkout .bashrc
# Load NVM
# shellcheck source=./.profile
source "$HOME/.profile"

nvm install node
