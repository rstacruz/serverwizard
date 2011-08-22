if [ $# == 0 ]; then
    echo Usage: $0 user@hostname
    exit 65
fi

echo "Connecting to $1..."
tar -zc . | ssh $* -- "mkdir -p /tmp/bootstrap-sh; cd /tmp/bootstrap-sh; tar -zxf -"
ssh -t $* -- "cd /tmp/bootstrap-sh && sudo bash < bootstrap.sh"
