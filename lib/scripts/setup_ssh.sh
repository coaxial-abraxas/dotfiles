#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

key_file="$HOME/.ssh/id_rsa"

if [ ! -f "$key_file" ]
then
  printf "%s doesn't exist, generating a pair.\n" "$key_file"
  printf "Enter your email: "
  read -r user_email
  ssh-keygen -t rsa -b 4096 -C "$user_email" -N "" -f "$key_file"
fi

printf "Your public key is:\n"
cat "$key_file.pub"
printf "\n"

eval "$(ssh-agent -s)" 1>/dev/null
ssh-add "$key_file"
