#!/usr/bin/env bats

setup() {
    path=$(pwd)
    DIR_PATH=$(dirname "$path")

    export SRC_BASE_DIR="${DIR_PATH}/src"
    export DEBUG="true"
    export INPUT_ACTION_DOCS_TEMPLATE_FILE="${DIR_PATH}/src/default_template.tpl"
    export INPUT_ACTION_DOCS_GIT_COMMIT_MESSAGE="Automatic commit"
    
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load './fixtures.bash'
}

teardown() {
    echo "clean temp dir"
    rm -rf "${BATS_TEST_DIRNAME}/tmp"  
}

setup_file() {
    # cd into the directory containing the bats file    
    cd "$BATS_TEST_DIRNAME" || exit 1
    echo "$BATS_TEST_DIRNAME"
}

teardown_file() {
    echo "clean temp dir"
    rm -rf "${BATS_TEST_DIRNAME}/tmp"
}

@test "Should commit README.md" {

    export GITHUB_WORKSPACE="${BATS_TEST_DIRNAME}/tmp/local"
    export GITHUB_HEAD_REF='test-branch'
    export GITHUB_ACTOR='autotest'
    export INPUT_ACTION_DOCS_WORKING_DIR="${GITHUB_WORKSPACE}"
    export INPUT_ACTION_DOCS_DEBUG_MODE='true'
    export INPUT_ACTION_DOCS_GIT_PUSH='true'
 
    config_test_env "$GITHUB_WORKSPACE"

    run "${SRC_BASE_DIR}/docker-entrypoint.sh"

    assert_success
    assert_output --partial "Automatic commit"
}

@test "Should not commit README.md" {

    export GITHUB_WORKSPACE="${BATS_TEST_DIRNAME}/tmp/local"
    export GITHUB_HEAD_REF='test-branch'
    export GITHUB_ACTOR='autotest'
    export INPUT_ACTION_DOCS_WORKING_DIR="${GITHUB_WORKSPACE}"
    export INPUT_ACTION_DOCS_DEBUG_MODE='true'
    export INPUT_ACTION_DOCS_GIT_PUSH='false'
 
    config_test_env "$GITHUB_WORKSPACE"

    run "${SRC_BASE_DIR}/docker-entrypoint.sh"

    assert_success
    assert_output --partial "name=num_changed::1"
}