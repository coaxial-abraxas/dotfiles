#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

declare -a scripts=(\
  bootstrap*.sh\
  lib/scripts/*.sh\
  .bash_*\
  .bashrc\
  .profile\
)

for script in "${scripts[@]}"; do
  # ignore vim swap files and artifacts
  if [[ ! "$script" =~ ~$|sw.?$ ]]; then
    bash -n "$script"
    shellcheck -x "$script"
  fi
done
