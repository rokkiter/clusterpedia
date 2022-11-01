#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


GITLAB_EMAIL="101091030+rokkiter@users.noreply.github.com"
GITLAB_USER_NAME="rokkiter"
GITLAB_USER_PASSWORD="Qq28605181"
# todo token需要切换
Token=${APIREPOTOKEN}
CI_COMMIT_TAG="test"

echo "~~~~~~~~~~~success do it"

REPO_ROOT=$(git rev-parse --show-toplevel)
API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
API_REPO="https://$Token@github.com/rokkiter/api.git"

TMP_DIR="/tmp/clusterpedia-api-$RANDOM"
echo "------dir:$TMP_DIR"

SOURCE_BRANCH="main"


# init name && email config
init_config(){
  git config --global user.email "$GITLAB_EMAIL"
  git config --global user.name "$GITLAB_USER_NAME"
}

# check tag, if exist, delete it
check_tag(){
  if [ -n "$(git ls-remote --tags origin -l $CI_COMMIT_TAG)" ]; then
    echo "tag already exist, delete it before retag"
    git push -d origin $CI_COMMIT_TAG
    git tag -d $CI_COMMIT_TAG
  fi
}

# sync api repo then create tag
sync_create_tag(){
  git clone $API_REPO $TMP_DIR

  rm -rf $TMP_DIR/*
  cp -r $API_ROOT/* $TMP_DIR
  cd $TMP_DIR

  echo "----create tag"
  if [ -n "$(git status | grep 'nothing to commit, working tree clean')" ]
  then
    echo "----api repo is not diff~"
  else
    git add .
    git commit -m "tag:$CI_COMMIT_TAG sync api folder from ghippo repo"
    echo "----1"
    git push
    echo "----2"
  fi

#  check_tag
  git tag $CI_COMMIT_TAG -a -m "create tag"
  git push
  echo "push tag success~"

  cd -
  rm -rf $TMP_DIR
}

init_config

sync_create_tag