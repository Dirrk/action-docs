#!/usr/bin/env bash

debug_message(){
    msg="$1"

    if [ "$INPUT_ACTION_DOCS_DEBUG_MODE" == "true" ];then
        echo "$msg"
    fi
}