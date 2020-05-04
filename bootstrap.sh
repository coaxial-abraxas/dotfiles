#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# Detects the OS and chooses the appropriate bootstrap script

function detect_os {
  if [ "$(uname)" == "Darwin" ]; then
    echo "OSX"
  elif [ "$(uname)" == "Linux" ]; then
    echo "Linux"
  else
    echo "Couldn't detect OS or incompatible OS, sorry."
    exit 1
  fi
}

current_os="$(uname | tr '[:upper:]' '[:lower:]')"

printf "Yay, a new machine! Let's set it up...\n"
printf "Detected OS is \"%s\"\n" "$(detect_os)"
read -r -p "Continue? [Y/n] " continue
continue=${continue:-"y"}

if [[ "$continue" != @(y|Y) ]]
then
  printf "Exiting."
  exit 0
fi

printf "Configuring %s...\n" "$current_os"
"./bootstrap_$current_os.sh"

printf "All done!\n"
