#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
if [ ! -f "$HOME/.rvm/bin/rvm" ]; then
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable --ruby
else
  printf "RVM is already installed, not reinstalling.\n"
fi

echo "For the maid daily cronjob to work, don't forget to run \`rvm alias create maid ruby-<ruby-version>@maid --create\`"
