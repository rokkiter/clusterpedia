#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

Token=${APIREPOTOKEN}
CI_COMMIT_TAG="test"

REPO_ROOT=$(git rev-parse --show-toplevel)
API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
API_REPO="https://$Token@github.com/rokkiter/api.git"

GITLAB_EMAIL="101091030+rokkiter@users.noreply.github.com"
GITLAB_USER_NAME="rokkiter"

# api仓库暂存地址
TMP_DIR="/tmp/clusterpedia-api-$RANDOM"

# init name && email config
init_config(){
  git config --global user.email "$GITLAB_EMAIL"
  git config --global user.name "$GITLAB_USER_NAME"
}

check_tag(){
  if [ -n "$(git ls-remote --tags origin -l $CI_COMMIT_TAG)" ]; then
    echo "tag already exist, delete it before retag"
    git push -d origin $CI_COMMIT_TAG
    git tag -d $CI_COMMIT_TAG
  fi
}

sync_create_tag(){
  git clone $API_REPO $TMP_DIR

  rm -rf $TMP_DIR/*
  cp -r $API_ROOT/* $TMP_DIR
  cd $TMP_DIR

  check_tag
  git add .
  git commit -m "tag:$CI_COMMIT_TAG sync api folder from ghippo repo"
  git push

  git tag $CI_COMMIT_TAG -a -m "create tag"
  git push origin $CI_COMMIT_TAG
  echo "push tag success~"

  cd -
  rm -rf $TMP_DIR
}

init_config

sync_create_tag