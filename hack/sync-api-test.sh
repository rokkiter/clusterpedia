#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)
API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
API_REPO="https://$APIREPOTOKEN@github.com/rokkiter/api.git"

# todo 放到secret里面
GITLAB_EMAIL="101091030+rokkiter@users.noreply.github.com"
GITLAB_USER_NAME="rokkiter"

TMP_DIR="/tmp/clusterpedia-api-$RANDOM"


# init name && email config
init_config(){
  git config --global user.email "$GITLAB_EMAIL"
  git config --global user.name "$GITLAB_USER_NAME"
}

check_branch(){
  if [ -z "$(git ls-remote --exit-code --heads origin $BRANCHNAME)" ]; then
    echo "remote branch does not exist, create it"
    git checkout -b $BRANCHNAME
    git push --set-upstream origin $BRANCHNAME
  fi
}

sync_api(){
  git clone $API_REPO $TMP_DIR

  rm -rf $TMP_DIR/*
  cp -r $API_ROOT/* $TMP_DIR
  cd $TMP_DIR

  check_branch
  git add .

  git commit -m $MESSAGE
  git push

  cd -
  rm -rf $TMP_DIR
}

if [ $REFTYPE != 'branch' ]; then
  exit 0
fi

init_config

sync_api