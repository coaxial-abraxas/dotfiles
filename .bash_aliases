#!/usr/bin/env bash

# Useful aliases
if [[ $OSTYPE =~ linux ]]; then
  alias ll='ls -lah --color=auto'
else
  alias ll='ls -laGh'
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

# Let's give this dev journal a try
alias journal='cd ~/code/journal && vim `date +"%Y-%m-%d"`.md'

# Requires AnyBar and hub
# Checks the ci-status on GitHub and changes the dot color accordingly
alias ciw='echo -n "question" | nc -4u -w0 localhost 1738; while true; do if [ "$(hub ci-status)" == "pending" ]; then echo -n "orange" | nc -4u -w0 localhost 1738; elif [ "$(hub ci-status)" == "success" ]; then echo -n "green" | nc -4u -w0 localhost 1738; break; else echo -n "red" | nc -4u -w0 localhost 1738; fi; sleep 5; done &'
