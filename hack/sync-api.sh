#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function usage() {
    cat <<EOF
ENV:
    RAW: current repo the branch which contain github action ${{ github_ref }}
    BRANCH_NAME: current branch name
        eg. BRANCH_NAME=main
    GH_TOKEN: github token for api repo auth.
EOF
}

set +e; RAW=$(git branch -r --contains $REF 2>/dev/null);set -e
if [ -z $RAW ]; then
    echo "the current directory is not in the clusterpedia path"
    usege
    exit 1
else
    BRANCH_NAME=${RAW/origin\/}
    if [ -z $BRANCH_NAME ]; then
        echo "can not get current branch"
        usage
        exit 1
    fi
fi

if [ -z $GH_TOKEN ]; then
    echo "the github token is not in the env, please check CLUSTERPEDIA_BOT_TOKEN"
    usage
    exit 1
else
    #todo  测试仓库，需修改
    API_REPO="https://$GH_TOKEN@github.com/rokkiter/api.git"
fi

TAG_MESSAGE=$(git tag -l --format="%(contents)" $TAGNAME)

install_filter_repo(){
    python3 -m pip install --user git-filter-repo
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

sync_api

