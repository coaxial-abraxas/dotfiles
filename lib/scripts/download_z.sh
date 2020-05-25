#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
echo 'Downloading z.sh...'
curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ~/z.sh
chmod +x ~/z.sh
echo 'Done.'
