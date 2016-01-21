#!/usr/bin/env bash
# Links dotfiles from the repo to ~
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../.."
ln -s "$DIR"/{.bashrc,.gemrc,.gitconfig,.gitignore_global,.gvimrc,.irssi,.vimrc,.bash_aliases,.bash_prompt,.path} ~
