#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)
API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
API_REPO="https://$GH_TOKEN@github.com/rokkiter/api.git"

raw=$(git branch -r --contains $REF)
BRANCH_NAME=${raw/origin\/}

TAG_MESSAGE=""

install_filter_repo(){
  python3 -m pip install --user git-filter-repo
}

# get tag message
init_tag_message(){
  TAG_MESSAGE=$(git tag -l --format="%(contents)" $TAGNAME)
}

# check tag, if exist, delete it
check_tag(){
  git tag -d $TAGNAME
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
      git filter-repo --subdirectory-filter staging/src/github.com/clusterpedia-io/api --force
      git remote add origin $API_REPO
      check_tag
      git tag $TAGNAME -a -m $TAG_MESSAGE
      git push origin $TAGNAME
      echo "push tag success~"
    else
      git filter-repo --subdirectory-filter staging/src/github.com/clusterpedia-io/api --force
      git remote add origin $API_REPO
      git push origin $BRANCH_NAME
      echo "sync code success~"
  fi
}

install_filter_repo

init_tag_message

sync_api
