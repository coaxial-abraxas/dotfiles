#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
