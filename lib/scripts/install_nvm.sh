#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
