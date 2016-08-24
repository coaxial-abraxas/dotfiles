#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$HOME/.profile"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in $HOME/.{path,bash_prompt,exports,bash_aliases,functions,extra}; do
  # shellcheck disable=SC1090
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# nvm
# shellcheck disable=SC2046
if  [ -f $(brew --prefix nvm)/nvm.sh ] && [[ $OSTYPE =~ darwin ]]; then # checks if the nvm command exists
  export NVM_DIR=~/.nvm
  # shellcheck disable=SC2046
  # shellcheck disable=SC1090
  source $(brew --prefix nvm)/nvm.sh
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion;
fi;

# Thanks to @tmoitie, adds more tab completion for bash,
# also when hitting tab twice it will show a list.
# shellcheck disable=SC2046
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    # shellcheck disable=SC2046
    . $(brew --prefix)/etc/bash_completion
fi

# Set env vars for docker if docker-machine is a valid command
if command -v docker-machine &>/dev/null; then
  # Check if the docker daemon is running (See https://github.com/Coaxial/dotfiles/issues/3)
  if docker-machine ip default &>/dev/null; then
    eval "$(docker-machine env default)"
  fi
fi

# Save history as we enter commands instead of waiting to close the terminal
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Storage is cheap so lets keep a large history
HISTSIZE=50000
HISTFILESIZE=500000

# Disable terminal freeze so Ctrl-s works when searching the history
stty -ixon

# Set the default editor to be vim
# shellcheck disable=SC2155
export EDITOR=$(which vim)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Edit commands in $EDITOR by typing `Esc` at the prompt
set -o vi
