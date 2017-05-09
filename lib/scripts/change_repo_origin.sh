#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

git_protocol="$(git config --get remote.origin.url | cut -d ':' -f 1)"

if [ "$git_protocol" = "https" ]; then
  # Now that git keys have been generated, change origin from https to ssh
  git_hostname="$(git config --get remote.origin.url | cut -d '/' -f 3)"
  git_user="$(git config --get remote.origin.url | cut -d '/' -f 4)"
  git_repo="$(git config --get remote.origin.url | cut -d '/' -f 5)"

  git remote set-url origin "git@$git_hostname:/$git_user/$git_repo"
fi
