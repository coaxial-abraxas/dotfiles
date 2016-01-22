#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# https://github.com/VundleVim/Vundle.vim#quick-start
ln -s ./vundle ~/.vim.bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall
