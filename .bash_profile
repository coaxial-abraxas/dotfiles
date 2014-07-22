# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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
    source /etc/bash_completion;
fi;

# Thanks to @tmoitie, adds more tab completion for bash,
# also when hitting tab twice it will show a list.
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi



# A nicer prompt
# Define some colors
BLACK="\e[0;30m"
BLACKBOLD="\e[1;30m"
RED="\e[0;31m"
REDBOLD="\e[1;31m"
GREEN="\e[0;32m"
GREENBOLD="\e[1;32m"
YELLOW="\e[0;33m"
YELLOWBOLD="\e[1;33m"
BLUE="\e[0;34m"
BLUEBOLD="\e[1;34m"
PURPLE="\e[0;35m"
PURPLEBOLD="\e[1;35m"
CYAN="\e[0;36m"
CYANBOLD="\e[1;36m"
WHITE="\e[0;37m"
WHITEBOLD="\e[1;37m"
RESET="\e[0m"

# And some helper functions
# Heavily inspired from http://blog.deadlypenguin.com/blog/2013/10/24/adding-git-status-to-bash/
function _git_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=$GREENBOLD
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=$REDBOLD
    else
      local ansi=$YELLOWBOLD
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      #test "$branch" != master || branch=' '
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
      echo HEAD`)"
    fi
    echo -n '[\['"$ansi"'\]'"$branch"'\[\e[0m\]]'
  fi
}
 
function report_status() {
  RET_CODE=$?
  if [[ $RET_CODE -ne 0 ]] ; then
    echo -ne "[\[$RED\]$RET_CODE\[$NC\]]"
  fi
}
 
export _PS1="$WHITEBOLD\[$NC\] \w"
export PS2="\[$NC\]> "
export PROMPT_COMMAND='_status=$(report_status);export PS1="$(_git_prompt)${_status}${_PS1}\$ $RESET";unset _status;'