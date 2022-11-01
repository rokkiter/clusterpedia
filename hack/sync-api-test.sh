#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

Token=${APIREPOTOKEN}
CI_COMMIT_TAG="test"

REPO_ROOT=$(git rev-parse --show-toplevel)
API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
API_REPO="https://$Token@github.com/rokkiter/api.git"

# api仓库暂存地址
TMP_DIR="/tmp/clusterpedia-api-$RANDOM"

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

  if [ -n "$(git status | grep 'nothing to commit, working tree clean')" ]
  then
    echo "----api repo is not diff~"
  else
    check_tag
    git add .
    git commit -m "tag:$CI_COMMIT_TAG sync api folder from ghippo repo"
    git push
  fi

  git tag $CI_COMMIT_TAG -a -m "create tag"
  git push origin $CI_COMMIT_TAG
  echo "push tag success~"

  cd -
  rm -rf $TMP_DIR
}


sync_create_tag