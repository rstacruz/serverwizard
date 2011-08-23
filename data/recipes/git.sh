# name: Git
# position: 40
# needs:
#   - _aptupdate

ensure_updated_apt

installing "Git client"
apt-get install -y git-core
