#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)
API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
API_REPO="https://$API_REPO_TOKEN@github.com/rokkiter/api.git"

# todo 放到secret里面
GITLAB_EMAIL="101091030+rokkiter@users.noreply.github.com"
GITLAB_USER_NAME="rokkiter"

TMP_DIR="/tmp/clusterpedia-api-$RANDOM"

raw=$(git branch -r --contains $REF)
BRANCH_NAME=${raw/origin\/}

TAG_MESSAGE=""

install_filter_repo(){
  python3 -m pip install --user git-filter-repo
}

# 获取 clusterpedia 的 tag message
init_tag_message(){
  TAG_MESSAGE=$(git tag -l --format="%(contents)" $TAGNAME)
}

echo "test" $BRANCH_NAME

# init name && email config
init_config(){
  git config --global user.email "$GITLAB_EMAIL"
  git config --global user.name "$GITLAB_USER_NAME"
}

# check tag, if exist, delete it
check_tag(){
  if [ -n "$(git ls-remote --tags origin -l $TAGNAME)" ]; then
    echo "tag already exist, delete it before retag"
    git push -d origin $TAGNAME
    git tag -d $TAGNAME
  fi
}

check_branch(){
  if [ -z "$(git ls-remote --exit-code --heads origin $BRANCH_NAME)" ]; then
      echo "remote branch does not exist, create it"
      git checkout -b $BRANCH_NAME
      git push --set-upstream origin $BRANCH_NAME
    else
      git checkout $BRANCH_NAME
  fi
}

sync_api(){

  if [ $REFTYPE == "tag" ]; then
      git clone $API_REPO $TMP_DIR
      cd $TMP_DIR
      check_branch
      cd -

      rm -rf $TMP_DIR/*
      cp -r $API_ROOT/* $TMP_DIR
      cd $TMP_DIR

      check_tag
      git tag $TAGNAME -a -m $TAG_MESSAGE
      git push origin $TAGNAME
      echo "push tag success~"
      cd -
      rm -rf $TMP_DIR
    else
      git filter-repo --subdirectory-filter staging/src/github.com/clusterpedia-io/api --force
      git remote add origin $API_REPO
      check_branch
      git push origin $BRANCH_NAME  --allow-unrelated-histories
  fi


}

install_filter_repo

init_tag_message

init_config

sync_api