#!/bin/bash
set -e

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname "$path")

# shellcheck source=/dev/null
source "${DIR_PATH}/utils.sh"


git_add_doc () {
  debug_message "Into git_add_doc"

  MY_FILE="${1}"
  git add "${MY_FILE}"
}

git_changed () {
  debug_message "Into git_changed"

  GIT_FILES_CHANGED=`git status --porcelain | grep -E '([MA]\W).+' | wc -l`
  echo "num_changed=${GIT_FILES_CHANGED}" >> $GITHUB_OUTPUT

  debug_message "End git_changed"
}

git_setup () {
  debug_message "Into git_setup"

  git config --global user.name ${GITHUB_ACTOR}
  git config --global user.email ${GITHUB_ACTOR}@users.noreply.github.com
  if $(git rev-parse --is-shallow-repository); then git fetch --unshallow ; fi
  git checkout "${GITHUB_HEAD_REF}"

  debug_message "End git_setup"


  # git fetch --depth=1 origin +refs/tags/*:refs/tags/*
  # if [ "${GITHUB_EVENT_NAME}" == 'pull_request' ]; then
  #   git checkout "${GITHUB_HEAD_REF}"
  #   # git reset --hard "${GITHUB_SHA}"
  # fi
}

git_commit () {
  debug_message "Into git_commit"

  git_changed
  if [ "${GIT_FILES_CHANGED}" -eq 0 ]; then
    echo "::debug file=common.sh,line=20,col=1 No files changed, skipping commit"
  else
    git commit -m "${INPUT_ACTION_DOCS_GIT_COMMIT_MESSAGE}"
  fi
}

update_doc () {
  debug_message "Into update_doc"
  
  WORKING_DIR="${1}"

  debug_message "WORKING_DIR : [ $WORKING_DIR ]"

  if [ ! -f "${WORKING_DIR}/action.yml" ]; then
    echo "::error file=common.sh,line=35,col=1::action.yml does not exist"
    exit 2
  fi

  echo "Create the documentation"
  gomplate -d action=${WORKING_DIR}/action.yml -f "${INPUT_ACTION_DOCS_TEMPLATE_FILE}" -o /tmp/action_doc.md

  # Create README.md if it doesn't exist
  if [ ! -f "${WORKING_DIR}/README.md" ]; then
     gomplate -d action=${WORKING_DIR}/action.yml -f /src/README.tpl -o "${WORKING_DIR}/README.md"
  fi

  HAS_ACTION_DOCS=`grep -E '(BEGIN|END)_ACTION_DOCS' "${WORKING_DIR}/README.md" | wc -l`

  # Verify it has BEGIN and END markers
  if [ "${HAS_ACTION_DOCS}" -ne 2 ]; then
    echo "::error file=common.sh,line=44,col=1::README.md does not contain <!--- BEGIN_ACTION_DOCS ---> and <!--- END_ACTION_DOCS --->"
    exit 3
  fi

  sed -i -ne '/<!--- BEGIN_ACTION_DOCS --->/ {p; r /tmp/action_doc.md' -e ':a; n; /<!--- END_ACTION_DOCS --->/ {p; b}; ba}; p' "${WORKING_DIR}/README.md"
  git_add_doc "${WORKING_DIR}/README.md"

  debug_message "End update_doc"
}

cd $GITHUB_WORKSPACE
git_setup

update_doc "${INPUT_ACTION_DOCS_WORKING_DIR}"

if [ "${INPUT_ACTION_DOCS_GIT_PUSH}" = "true" ]; then
  git_commit
  git push origin HEAD:"${GITHUB_HEAD_REF}" -f

  if [ "$INPUT_ACTION_DOCS_DEBUG_MODE" == "true" ];then
    git log
  fi
else
  git_changed
fi

exit 0
