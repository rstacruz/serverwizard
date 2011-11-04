# #### BEGIN SCRIPT INFO ###
# name: My user
# position: 10
# description: Sets up a user for you.
# fields:
#   MY_USER:
#     name: My username
#   SSH_PUBKEY:
#     name: Public SSH key
#     description: Paste this from ~/.ssh/id_rsa.pub.
# notes: |
#  * If you need an SSH key, download (*.tar.gz*) the script and add the files `ssh/id_rsa.pub` and `ssh/id_rsa`.
# #### END SCRIPT INFO #####

status "Creating your user $MY_USER..."
useradd $MY_USER --home "/home/$MY_USER" --create-home --shell /bin/bash
addgroup $MY_USER admin

status  "Note: this user has no password."
status_ "Set one by typing 'sudo passwd $MY_USER'"

status "Setting up SSH access for to $MY_USER..."
mkdir /home/$MY_USER/.ssh
echo $SSH_PUBKEY > /home/$MY_USER/.ssh/authorized_keys
chmod 700 /home/$MY_USER/.ssh
chmod 600 /home/$MY_USER/.ssh/authorized_keys
chown -R $MY_USER:$MY_USER /home/$MY_USER/.ssh

if [ -f "$DIR/ssh/id_rsa" ]; then
  status "Adding private key to $MY_USER..."
  cat "$DIR/ssh/id_rsa" > /home/$MY_USER/.ssh/id_rsa
  chmod 600 /home/$MY_USER/.ssh/id_rsa
fi

if [ -f "$DIR/ssh/id_rsa.pub" ]; then
  status "Adding public key to $MY_USER..."
  cat "$DIR/ssh/id_rsa.pub" > /home/$MY_USER/.ssh/id_rsa.pub
  chmod 644 /home/$MY_USER/.ssh/id_rsa.pub
fi

# Ensure permissions are correct.
chown -R $MY_USER:$MY_USER /home/$MY_USER/.ssh

