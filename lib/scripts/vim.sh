#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# Packages required by YCM
sudo apt install build-essential cmake python3-dev -yqq

sudo apt install vim -yqq
vim +PlugInstall +qall
