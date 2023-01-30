#!/bin/bash

config_test_env(){
    WORKING_DIR=$1

    _create_repo "${BATS_TEST_DIRNAME}/tmp/remote"
    cd "${BATS_TEST_DIRNAME}/tmp/remote"
    _create_initial_commit
    git branch "${GITHUB_HEAD_REF}"
    COMMIT_SHA=$(_get_latest_commit)

    _create_repo "$WORKING_DIR"
    cd "$WORKING_DIR"
    git remote add origin "${BATS_TEST_DIRNAME}/tmp/remote"
    git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin "$COMMIT_SHA":"${GITHUB_HEAD_REF}"
}

_create_repo(){
    name=$1

    git init $name
}

_create_initial_commit(){
    _init_readme
    cp ${DIR_PATH}/action.yml .
    git add README.md action.yml
    git commit -sm 'initial commit'
}

_get_latest_commit(){
    echo "$(git rev-parse --verify HEAD)"
}

_init_readme(){
cat <<EOF > README.md
<!--- BEGIN_ACTION_DOCS --->
<!--- END_ACTION_DOCS --->
EOF
}

_update_readme(){
    echo 'fin' >> README.md
}

# mkdir -p test
# cd test

# create_remote_repo remote
# REMOTE_PATH="${BATS_TEST_DIRNAME}/tmp/remote"

# COMMIT=$(get_latest_commit $REMOTE_PATH)
# echo "$COMMIT"

# mkdir -p "${BATS_TEST_DIRNAME}/tmp/local" && cd "${BATS_TEST_DIRNAME}/tmp/local"
# git init
# git remote add origin "$REMOTE_PATH"
# git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin "$COMMIT":mabranche

# git branch -la
# git checkout mabranche
# echo 'fin' >> README.md
# git add README.md
# git commit -sm 'update readme'

# git push origin HEAD:main
# git log --first-parent
# ##############################

# # git checkout -b "test"
# # git fetch --unshallow

# rm -rf "${BATS_TEST_DIRNAME}/tmp"
