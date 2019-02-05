#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

os="$1"

if [ "$os" == "OSX" ]; then
  fonts_dir="$HOME/Library/Fonts/"
elif [ "$os" == "Linux" ]; then
  fonts_dir="$HOME/.fonts/"
fi

# Downloads and copies over Anonymous Pro
curl https://www.marksimonson.com/assets/content/fonts/AnonymousPro-1.002.zip -o anonymous_font.zip -sS &&\
  unzip ./anonymous_font.zip -d "$fonts_dir" &&\
  rm anonymous_font.zip
# and Terminus
curl https://files.ax86.net/terminus-ttf/files/latest.zip -o terminus_font.zip -sS &&\
  unzip ./terminus_font.zip -d "$fonts_dir" &&\
  rm terminus_font.zip
