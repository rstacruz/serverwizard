# name: Git user
# description: Creates a git user.
# implies:
#  - git
# files:
#  - gituser/git-create
# notes: |
#  - There's a user named `git` so you may remotely access repositories in your server.
#  - To create a repo, type this in the server:  
#    `git create repo`
#  - To use that repo type this in your local machine:  
#   `git remote add origin git@SERVERNAME:repo.git`

status "Creating the Git user..."
useradd git --home /home/git --create-home --shell /usr/bin/git-shell

if [ -n "$SSH_PUBKEY" ]; then
  status "Setting up SSH keys..."
  mkdir /home/git/.ssh
  echo $SSH_PUBKEY > /home/git/.ssh/authorized_keys
  chmod 700 /home/git/.ssh
  chmod 400 /home/git/.ssh/authorized_keys
  chown -R git:git /home/git/.ssh
fi

GIT_CREATE=/usr/local/bin/git-create
status "Setting up 'git create' ($GIT_CREATE)..."
cat_file gituser/git-create > $GIT_CREATE
chmod 755 /usr/local/bin/git-create

status "Git user created."
status "To create a repo:  git create myreponame"
status "To use that repo:  git add git@SERVERNAME:myreponame.git"
