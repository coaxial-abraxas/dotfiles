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
alias ciw='while true; do
  icon="question"
  ci_status="$(hub ci-status)"

  case "$ci_status" in
  "pending")
    icon="orange"
    ;;
  "success")
    icon="green"
    ;;
  "failure")
    icon="red"
    ;;
  *)
    icon="question"
    ;;
  esac
  
  echo -n "${icon}" | nc -4u -w0 localhost 1738
  
  if [ $icon == "green" ] || [ $icon == "red" ]; then
    break
  fi
  
  sleep 5;
done &'

# tree in a node project outputs a lot of cruft
alias tnode='tree -I node_modules'
