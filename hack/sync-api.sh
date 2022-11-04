#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function usage() {
    cat <<EOF
ENV:
    REF: if you want to push code to api repo in one branch the format is refs/heads/<branch_name>,
         if you want to push tag to api repo the format is is refs/tags/<tag_name>
    REFTYPE: the current operation is tag or sync code. if it is undefined, it defaults to branch
        eg. REFTYPE=tag  or  REFTYPE=branch
    REFNAME: the name of the branch or tag, when REFTYPE=tag it mean the name of tag,
        otherwise it mean the name of branch
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

if [ -z $GH_TOKEN ]; then
    echo "the github token is not in the env, please check GH_TOKEN"
    usage
    exit 1
fi

if [ -z $REFNAME ]; then
    echo "can not find refg"
    usage
    exit 1
fi

API_REPO="https://$GH_TOKEN@github.com/clusterpedia/api.git"

install_filter_repo(){
    python3 -m pip install --user git-filter-repo
}

TMP_CLUSTERPEDIA=/tmp/clusterpedia
create_tmp_dir(){
    mkdir -p $TMP_CLUSTERPEDIA
    git clone ./ $TMP_CLUSTERPEDIA
    cd $TMP_CLUSTERPEDIA
}

# check tag, if exist, delete it
check_tag(){
    if [ -n "$(git ls-remote --tags api-origin -l $TAGNAME)" ]; then
        echo "tag already exist, delete it before retag"
        git push -d api-origin $TAGNAME
    fi
}

clean_tmp_dir(){
    cd -
    rm -rf $TMP_CLUSTERPEDIA
}

sync_api(){
  create_tmp_dir
  if [ $REFTYPE == "tag" ]; then
      git filter-repo --subdirectory-filter $API_ROOT
      git remote add api-origin $API_REPO
      check_tag
      git push api-origin $REFNAME
      echo "push tag success~"
    else
      git filter-repo --subdirectory-filter $API_ROOT
      git remote add api-origin $API_REPO
      git push api-origin $REFNAME
      echo "sync code success~"
  fi
  clean_tmp_dir
}

install_filter_repo

sync_api
