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

API_ROOT="staging/src/github.com/clusterpedia-io/api"
if [ ! -d $API_ROOT ];then
    echo "can not find API_ROOT in the path, please check in the clusterpedia root path"
    exit 1
fi

set +e; RAW=$(git branch -r --contains $REF 2>/dev/null);set -e
if [ -z $RAW ]; then
    echo "the current directory is not in the clusterpedia path"
    usege
    exit 1
fi

BRANCH_NAME=${RAW/origin\/}
if [ -z $BRANCH_NAME ]; then
    echo "can not get current branch"
    usage
    exit 1
fi

if [ -z $GH_TOKEN ]; then
    echo "the github token is not in the env, please check GH_TOKEN"
    usage
    exit 1
fi
#todo  need change
API_REPO="https://$GH_TOKEN@github.com/rokkiter/api.git"

TAG_MESSAGE=$(git tag -l --format="%(contents)" $TAGNAME)

install_filter_repo(){
    python3 -m pip install --user git-filter-repo
}

TMP_CLUSTERPEDIA=/tmp/clusterpedia
create_tmp_dir(){
    mkdir -p $TMP_CLUSTERPEDIA && cp -rf ./* $TMP_CLUSTERPEDIA
    cd  $TMP_CLUSTERPEDIA
}

clean_tmp_dir(){
    cd /tmp
    rm -rf $TMP_CLUSTERPEDIA
}

# check tag, if exist, delete it
check_tag(){
    if [ -n "$(git ls-remote --tags origin -l $TAGNAME)" ]; then
        echo "tag already exist, delete it before retag"
        git push -d origin $TAGNAME
    fi
}

sync_api(){
  create_tmp_dir
  if [ $REFTYPE == "tag" ]; then
      git filter-repo --subdirectory-filter $API_ROOT
      git remote add origin $API_REPO
      check_tag
      git push origin $TAGNAME
      echo "push tag success~"
    else
      git filter-repo --subdirectory-filter $API_ROOT
      git remote add origin $API_REPO
      git push origin $BRANCH_NAME
      echo "sync code success~"
  fi
  clean_tmp_dir
}

install_filter_repo

sync_api

