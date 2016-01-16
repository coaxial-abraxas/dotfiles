#!/usr/bin/env bash
# Prepare and run Homebrew

# Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Enable Brewfile execution
brew tap Homebrew/bundle

# Apply Brewfile
brew bundle

# Remove artifacts
brew cleanup
brew cask cleanup

# Use brewed openssl
brew link openssl --force

# Link apps to /Applications
brew linkapps
