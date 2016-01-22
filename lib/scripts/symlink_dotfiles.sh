#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
# Links dotfiles from the repo to ~
ln -s {.bashrc,.gemrc,.gitconfig,.gitignore_global,.gvimrc,.irssi,.vimrc,.bash_aliases,.bash_prompt,.path} ~
