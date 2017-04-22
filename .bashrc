#!/usr/bin/env bash
# ^ Enable SC

# Expand variables set in .bash_profile to new terminals when only .bashrc is
# read. cf http://mywiki.wooledge.org/DotFiles

if [ -n "$BASH_VERSION" ]; then
  _is_bash=true
fi

# Override with local settings
if [ -f "$HOME/.bashrc_local" ]; then
  # shellcheck source=./.bashrc_local
  source "$HOME/.bashrc_local"
fi

# added by travis gem
# shellcheck disable=SC1090
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# shellcheck disable=SC1090
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function _tell_fortune {
  if hash fortune 2>/dev/null; then
    printf '\n'
    fortune -s # short fortunes only
  fi
}

function _set_bash_specific_options {
  if [ "$_is_bash" ]; then
    # Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob

    # Append to the Bash history file, rather than overwriting it
    shopt -s histappend

    # Autocorrect typos in path names when using `cd`
    shopt -s cdspell

    # Show expanded command before executing it
    shopt -s histverify
  fi
}

function _load_ancilliary_dotfiles {
  # * ~/.path can be used to extend `$PATH`.
  # * ~/.extra can be used for other settings you don’t want to commit.
  # Also see http://mywiki.wooledge.org/DotFiles for bashrc vs profile vs
  # bash_profile
  # In a nutshell:
  #   login shell: .profile -> .bashrc
  #   interactive shell: .bashrc only
  declare -a ancilliary_dotfiles=(\
    .bash_aliases \
    .bash_prompt \
    .path
  )

  for file in "${ancilliary_dotfiles[@]}"; do
    # shellcheck disable=SC1090
    if [ -f "$HOME/$file" ]; then
      source "$HOME/$file"
    fi
  done
}

function _ssh_hostname_completion {
  # SSH hostnames based on ~/.ssh/config, ignoring wildcards
  [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
}

function _enable_completion {
  if [ "$_is_bash" ]; then
    # Add tab completion for many Bash commands
    if hash brew 2>/dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
      # shellcheck disable=SC1090
      source "$(brew --prefix)/etc/bash_completion";
    elif [ -f /etc/bash_completion ]; then
      # shellcheck disable=SC1091
      source /etc/bash_completion;
    fi
  fi
}

function _setup_docker_client {
  # Set env vars for docker if docker-machine is a valid command
  if hash docker-machine 2>/dev/null; then
    # Check if the docker daemon is running (See https://github.com/Coaxial/dotfiles/issues/3)
    if docker-machine ip default &>/dev/null; then
      eval "$(docker-machine env default)"
    fi
  fi
}

function _tweak_history {
  # Save history as commands are entered
  export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

  # Storage is cheap
  export HISTSIZE=50000
  export HISTFILESIZE=500000

  # Disable terminal freeze so Ctrl-s works when searching the history
  stty -ixon
}

function _vim_ftw {
  if [ "$_is_bash" ]; then
    # Edit commands in $EDITOR by typing `Esc` at the prompt
    set -o vi
  fi
}

function _iterm2_features {
  if [ "$_is_bash" ]; then
    # shellcheck disable=SC1090
    # FIXME use if [ -f ]
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
  fi
}

function _load_nvm {
  [ -s "$NVM_DIR/nvm.sh" ] && source "$HVM_HOME/nvm.sh"
}

declare -a funcs=(\
  _enable_completion \
  _iterm2_features \
  _load_ancilliary_dotfiles \
  _load_nvm \
  _set_bash_specific_options \
  _setup_docker_client \
  _ssh_hostname_completion \
  _tell_fortune \
  _tweak_history \
  _vim_ftw \
)

for func in "${funcs[@]}"; do
  $func
  # no need to pollute the namespace with these functions
  unset "$func"
done

unset funcs
unset _is_bash
