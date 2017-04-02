# Expand variables set in .bash_profile to new terminals when only .bashrc is
# read. cf http://mywiki.wooledge.org/DotFiles
set +o histexpand

# Override with local settings
if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi

# added by travis gem
[ -f /Users/pierre/.travis/travis.sh ] && source /Users/pierre/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

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
    .exports \
    .extra \
    .functions \
    .path \
  )

  for file in "${ancilliary_dotfiles[@]}"; do
    # shellcheck disable=SC1090
    if [ -f "$HOME/$file" ]; then
      source "$HOME/$file"
    fi
  done
}


function _set_bash_specific_options {
  if [ "$_is_bash" ]; then
    # Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob

    # Append to the Bash history file, rather than overwriting it
    shopt -s histappend

    # Autocorrect typos in path names when using `cd`
    shopt -s cdspell
  fi
}

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

function _ssh_hostname_completion {
  # SSH hostnames based on ~/.ssh/config, ignoring wildcards
  [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
}

function _enable_completion {
  if [ "$_is_bash" ]; then
    # Add tab completion for many Bash commands
    if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
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
  if command -v docker-machine &>/dev/null; then
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
  # Set the default editor to be vim
  # shellcheck disable=SC2155
  export EDITOR=$(which vim)

  if [ "$_is_bash" ]; then
    # Edit commands in $EDITOR by typing `Esc` at the prompt
    set -o vi
  fi
}

function _iterm2_features {
  if [ "$_is_bash" ]; then
    # shellcheck disable=SC1090
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
  fi
}

declare -a funcs=(\
  _load_ancilliary_dotfiles \
  _set_bash_specific_options \
  _ssh_hostname_completion \
  _enable_completion \
  _setup_docker_client \
  _tweak_history \
  _vim_ftw \
  _iterm2_features \
)

for func in ${funcs[@]}; do
  $func
  unset $func
done

unset $funcs
