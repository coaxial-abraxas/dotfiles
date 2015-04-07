# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Storage is cheap so lets keep a large history
HISTSIZE=50000
HISTFILESIZE=500000

# Save history as we enter commands instead of waiting to close the terminal
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Disable terminal freeze so Ctrl-s works when searching the history
stty -ixon
