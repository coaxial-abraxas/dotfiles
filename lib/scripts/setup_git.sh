#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# This assumes there is a file at ~/.ssh/id_rsa.pub and that the comment
# section is only the email (which it should be if the scripts generated it
pubkey_email="$(cut -d ' ' -f 3 ~/.ssh/id_rsa.pub)"

printf '[user]\n' >> ~/.gitconfig_local
printf "  email = \"%s\"\n" "$pubkey_email" >> ~/.gitconfig_local

