#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# todo rename rokkiter line 17 , 41
function usage() {
    cat <<EOF
Build components:
    $0 <install-filter-repo|filter-repo|sync-api>
Build plugins:
    $0 plugins <filter-repo>
ENV:
    API_ROOT: clusterpedia api path, required if the pwd is not the api path.
        eg. API_ROOT=/home/runner/work/clusterpedia/staging/src/github.com/clusterpedia-io/api
    API_REPO: API_REPO: API_REPO git url with github token.
        eg. API_REPO=https://$GH_TOKEN@github.com/rokkiter/api.git
EOF
}

set +e; REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null);set -e
if [ -z $REPO_ROOT ]; then
    if [ -z $API_ROOT ]; then
        echo "the current directory is not in the clusterpedia api path, please set API_ROOT=<clusterpedia api path>"
        usage
    exit 1
    fi
        REPO_ROOT=$(pwd)
else
    API_ROOT="${REPO_ROOT}/staging/src/github.com/clusterpedia-io/api"
fi

if [ -z $GH_TOKEN ]; then
    if [ -z $API_REPO ]; then
        echo "the github token is not in the env, please check CLUSTERPEDIA_BOT_TOKEN"
        usage
    exit 1
    fi
else
    API_REPO="https://$GH_TOKEN@github.com/rokkiter/api.git"
fi

raw=$(git branch -r --contains $REF)
BRANCH_NAME=${raw/origin\/}


install_filter_repo(){
  python3 -m pip install --user git-filter-repo
}

TAG_MESSAGE=""
# 获取 clusterpedia 的 tag message
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
      echo "remote branch does not exist, create
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

install_filter_repo it"

init_tag_message

sync_api
