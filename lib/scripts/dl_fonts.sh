#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# Downloads and copies over Anonymous Pro
curl http://www.marksimonson.com/assets/content/fonts/AnonymousPro-1.002.zip -o anonymous_font.zip -sS &&\
  unzip anonymous_font.zip -d ~/Library/Fonts/ &&\
  rm anonymous_font.zip
