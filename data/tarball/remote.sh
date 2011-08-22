#!/usr/bin/env sh

if [ $# == 0 ]; then
    echo Usage: $0 user@hostname
    exit 65
fi

# Copy all files in the current path to the remote server.
echo "Copying files to $1..."
TMP_PATH="/tmp/bootstrap-sh-`date +%s`"
tar -zc . | ssh $* -- "mkdir -p $TMP_PATH; cd $TMP_PATH; tar -zxf -"

# Execute bootstrap.sh in the new remote path, then clean up when done.
echo "Running the bootstrap script in $1..."
ssh -t $* -- "cd $TMP_PATH && sudo bash < bootstrap.sh; rm -rf $TMP_PATH"
