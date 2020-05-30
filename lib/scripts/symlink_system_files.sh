#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../../root"
# Configures the trackpad, trackpoint, and trackball
declare -a systemfiles=(\
  usr/share/X11/xorg.conf.d/50-ltrac.conf \
  usr/share/X11/xorg.conf.d/50-trackpad.conf \
  usr/share/X11/xorg.conf.d/50-trackpoint.conf \
)

for systemfile in "${systemfiles[@]}"
do
  if [ -e "/${systemfile:-?}" ]
  then
    printf "File %s already exist in /, overwrite? [Y/n] " "$systemfile"
    read -r overwrite
    overwrite=${overwrite:-"y"}

    if [[ "$overwrite" != @(y|Y) ]]
    then
      continue
    fi

    rm -rf "/${systemfile:-?}"
  fi

  ln -s "$DIR/$systemfile" "/${systemfile:-?}"
done
