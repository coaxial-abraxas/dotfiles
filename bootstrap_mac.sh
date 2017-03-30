#!/usr/bin/env bash

printf 'Setting up SSH key...\n'
./lib/scripts/setup_ssh.sh

printf 'Configuring git...\n'
./lib/scripts/setup_git.sh
./lib/scripts/change_repo_origin.sh

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

printf 'Copying local overrides...\n'
./lib/scripts/cp_local.sh

printf 'Installing Vundle...\n'
./lib/scripts/vundle.sh

printf 'Installing RVM + Ruby...\n'
./lib/scripts/rvm_install.sh
