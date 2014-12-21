# Usage `brew bundle Brewfile`

# Make sure everything is up to date
update

# Upgrade anything already installed
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install bash
install bash-completion

tap homebrew/dupes
tap homebrew/versions

# Install the essentials
install git
install tree
install wget --enable-iri
install vim

# Install cask
tap caskroom/cask
tap caskroom/versions
install brew-cask

# And my favourtie apps
cask install airmail-beta
cask install alfred
cask install caffeine
cask install flux
cask install gfxcardstatus
cask install google-chrome
cask install iterm2
cask install jumpcut
cask install lastpass-universal
cask install limechat
cask install sublime-text3

# Add casks to Alfred
cask alfred link

# Remove outdated versions
cask cleanup
cleanup
