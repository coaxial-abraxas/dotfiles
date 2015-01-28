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

# nvm
export NVM_DIR="~/.nvm"
source $(brew --prefix nvm)/nvm.sh

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
# Colours and help from: https://github.com/nicholasjhenry/dotfiles/blob/master/bash/prompt
# And also http://misc.flogisoft.com/bash/tip_colors_and_formatting
# And http://mywiki.wooledge.org/BashFAQ/053

function bash_prompt {
  # Define some colors
  # regular colors
  k="\[\e[0;30m\]"    # black
  r="\[\e[0;31m\]"    # red
  g="\[\e[0;32m\]"    # green
  y="\[\e[0;33m\]"    # yellow
  b="\[\e[0;34m\]"    # blue
  m="\[\e[0;35m\]"    # magenta
  c="\[\e[0;36m\]"    # cyan
  w="\[\e[0;37m\]"    # white

  # emphasized (bolded) colors
  emk="\[\e[1;30m\]"
  emr="\[\e[1;31m\]"
  emg="\[\e[1;32m\]"
  emy="\[\e[1;33m\]"
  emb="\[\e[1;34m\]"
  emm="\[\e[1;35m\]"
  emc="\[\e[1;36m\]"
  emw="\[\e[1;37m\]"

  # background colors
  bgk="\[\e[40m\]"
  bgr="\[\e[41m\]"
  bgg="\[\e[42m\]"
  bgy="\[\e[43m\]"
  bgb="\[\e[44m\]"
  bgm="\[\e[45m\]"
  bgc="\[\e[46m\]"
  bgw="\[\e[47m\]"

  reset="\[\e[0m\]"

  UC=$w                       # user's color
  [ $UID -eq "0" ] && UC=$r   # root's color

  # Some helper functions
  # Heavily inspired from http://blog.deadlypenguin.com/blog/2013/10/24/adding-git-status-to-bash/
  function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
      if [[ "$git_status" =~ nothing\ to\ commit ]]; then
        local ansi=$emg
      elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
        local ansi=$emr
      else
        local ansi=$emy
      fi
      if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
        branch=${BASH_REMATCH[1]}
        #test "$branch" != master || branch=' '
      else
        # Detached HEAD.  (branch=HEAD is a faster alternative.)
        branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
        echo HEAD`)"
      fi
      echo -n '['$ansi$branch$reset'] '
    fi
  }

  export _PS1="$emr\$(~/.rvm/bin/rvm-prompt) $emc\w$reset"
  export PROMPT_COMMAND='export PS1="\n$reset$(_git_prompt)${_PS1}$reset\n$m\u@$emm\h$b \$ $reset";'
}

bash_prompt

# Useful aliases
alias ll='ls -la'
