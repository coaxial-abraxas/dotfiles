#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# Updates submodules and brings them up to date
git submodule update --init --recursive
git submodule update --init --remote
