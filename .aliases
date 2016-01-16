#!/usr/bin/env bash

# Useful aliases
if [[ $OSTYPE =~ "linux" ]]; then
  alias ll='ls -la --color=auto'
else
  alias ll='ls -laG'
fi
eval "$(hub alias -s)"

alias watch='watch --color'

alias now='date "+%Y%m%d_%H%M%S"'

alias fig='docker-compose'

alias v='vagrant'

# Put color in tree
alias tree='tree -C'

alias ssh='ssh -o VisualHostKey=yes'

# workaround to use vim as the crontab editor
# (http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place)
alias crontab="VIM_CRONTAB=true crontab"
