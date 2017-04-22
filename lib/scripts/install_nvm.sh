#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

# NVM adds its export to bashrc, but it's already in profile
git checkout .bashrc

# Avoids an unbound variable error within the nvm script
set +o nounset
source ~/.nvm/nvm.sh

nvm install node
set -o nounset
