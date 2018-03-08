#!/bin/bash
set -o nounset -o pipefail
shopt -s globstar nullglob dotglob

declare -a scripts=(\
  ./**/*.sh\
  .bash_aliases\
  .bash_prompt\
  .bashrc\
  .bashrc_local\
  .path\
  .profile\
  ./root/bin/lockscreen\
)

for script in "${scripts[@]}"; do
  echo "$script"
  bash -n "$script" || exit
  shellcheck -x "$script" || exit
done

