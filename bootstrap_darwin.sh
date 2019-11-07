#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

printf 'Setting up SSH key...\n'
./lib/scripts/setup_ssh.sh

printf 'Configuring git...\n'
./lib/scripts/setup_git.sh
./lib/scripts/change_repo_origin.sh

printf 'Installing fonts...\n'
./lib/scripts/dl_fonts.sh OSX

printf 'Installing Xcode...\n'
./lib/scripts/xcode_install.sh

printf 'Brewing apps...\n'
./lib/scripts/homebrew.sh

printf 'Linking dotfiles...\n'
./lib/scripts/symlink_dotfiles.sh

printf 'Copying local overrides...\n'
./lib/scripts/cp_local.sh

printf 'Installing RVM + Ruby...\n'
./lib/scripts/rvm_install.sh

printf 'Installing NVM + node...\n'
./lib/scripts/install_nvm.sh

printf 'Enabling latest bash...\n'
./lib/scripts/enable_latest_bash.sh
