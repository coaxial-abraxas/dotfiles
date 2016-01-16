#!/usr/bin/env bash

printf 'Updating submodules...\n'
./lib/scripts/update_submodules.sh

printf 'Installing fonts...\n'
./lib/scripts/dl_fonts.sh

printf 'Installing Xcode...\n'
./lib/scripts/xcode_install.sh

printf 'Brewing apps...\n'
./lib/scripts/homebrew.sh

printf 'Linking dotfiles...\n'
./lib/scripts/symlink_dotfiles.sh
