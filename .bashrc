if command -v rvm 2>/dev/null; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

# Override anything locally
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

# added by travis gem
[ -f /Users/pierre/.travis/travis.sh ] && source /Users/pierre/.travis/travis.sh
