#!/usr/bin/env bash

printf 'Installing fonts...\n'
./lib/scripts/dl_fonts.sh

printf 'Installing Xcode...\n'
./lib/scripts/xcode_install.sh

printf 'Brewing apps...\n'
./lib/scripts/homebrew.sh
