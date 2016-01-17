#!/usr/bin/env bash

# https://github.com/VundleVim/Vundle.vim#quick-start
ln -s ./vundle ~/.vim.bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall
