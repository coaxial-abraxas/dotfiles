#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../.."
declare -a dotfiles=(\
  .bashrc \
  .gemrc \
  .gitconfig \
  .gitignore_global \
  .gvimrc \
  .irssi \
  .vimrc \
  .bash_aliases \
  .bash_profile \
  .bash_prompt \
  .path\
)

for dotfile in "${dotfiles[@]}"
do
  if [ -f "$HOME/$dotfile" ]
  then
    printf "File %s already exist in ~, overwrite? [Y/n] " "$dotfile"
    read -r overwrite
    overwrite=${overwrite:-"y"}

    if [[ "$overwrite" != @(y|Y) ]]
    then
      continue
    fi
  fi

  rm "$HOME/$dotfile"
  ln -s "$DIR/$dotfile" "$HOME"
done
