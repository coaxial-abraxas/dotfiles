#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# Linux only script
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -yq
