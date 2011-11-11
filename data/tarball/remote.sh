#!/usr/bin/env sh

if [ $# == 0 ]; then
    echo Usage: $0 user@hostname
    exit 65
fi

[ -z "$FILE" ] && FILE="bootstrap.sh"

# Copy all files in the current path to the remote server.
echo "Copying files to $1..."
TMP_PATH="~/bootstrap-sh-`date +%s`$RANDOM"
tar -zc . | ssh $1 -- "mkdir -p $TMP_PATH; cd $TMP_PATH; tar zx"

# Execute bootstrap.sh in the new remote path, then clean up when done.
echo "Running $FILE on $1..."
ssh -t $1 -- "cd $TMP_PATH && sudo bash < $FILE; rm -rf $TMP_PATH"
