#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  # https://github.com/VundleVim/Vundle.vim#quick-start
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install plugins
vim +PluginInstall +qall
