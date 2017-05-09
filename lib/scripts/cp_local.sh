#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

for file in .*_local
do
  if [ -f "$HOME/$file" ]
  then
    read -r -p "$file already exists at $HOME/, overwrite? [Y/n] " overwrite
    overwrite=${overwrite:-"y"}

    if [[ "$overwrite" != @(y|Y) ]]
    then
      continue
    fi
  fi

  cp "$file" "$HOME/$file"
done
