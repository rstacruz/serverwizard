#!/usr/bin/env sh

if [ $# == 0 ]; then
    echo Usage: $0 user@hostname
    exit 65
fi

echo "Connecting to $1..."

TMP_PATH="/tmp/bootstrap-sh-`date +%s`"
tar -zc . | ssh $* -- "mkdir -p $TMP_PATH; cd $TMP_PATH; tar -zxf -"
ssh -t $* -- "cd $TMP_PATH && sudo bash < bootstrap.sh; rm -rf $TMP_PATH"
