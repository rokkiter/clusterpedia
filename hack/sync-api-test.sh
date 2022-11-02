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

# api仓库暂存文件夹
TMP_DIR="/tmp/clusterpedia-api-$RANDOM"

TAG_MESSAGE=""

# 获取 clusterpedia 的 tag message
init_tag_message(){
  TAG_MESSAGE=$(git tag -l --format="%(contents)" $TAGNAME)
}

# init name && email config
init_config(){
  git config --global user.email "$GITLAB_EMAIL"
  git config --global user.name "$GITLAB_USER_NAME"
}

check_tag(){
  if [ -n "$(git ls-remote --tags origin -l $TAGNAME)" ]; then
    echo "tag already exist, delete it before retag"
    git push -d origin $TAGNAME
    git tag -d $TAGNAME
  fi
}

sync_create_tag(){
  git clone $API_REPO $TMP_DIR

  rm -rf $TMP_DIR/*
  cp -r $API_ROOT/* $TMP_DIR
  cd $TMP_DIR

  git add .

  if [ $REFTYPE == "tag" ]; then
      check_tag
      git tag $TAGNAME -a -m "${TAG_MESSAGE}"
      git push origin $TAGNAME
      echo "push tag success~"
    else
      git commit -m $MESSAGE
      git push
  fi


  cd -
  rm -rf $TMP_DIR
}

init_config

if [ $REFTYPE == "tag" ]; then
    init_tag_message
fi

sync_create_tag