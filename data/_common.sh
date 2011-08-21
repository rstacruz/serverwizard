# name: Common

# Bootstrapper script

ensure_root() {
    if [ `whoami` != "root" ]; then
        echo "Run me as root!"
        exit
    fi
}

status() {
    echo -e "\033[0;32m*** $*\033[0;m"
}

installing() {
    echo -e "\033[0;32m*** Installing: $*...\033[0;m"
}
