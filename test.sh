#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


if [ ! -n git ls-remote --exit-code --heads  origin main ]; then
    echo "remote branch does not exist, create it"
fi