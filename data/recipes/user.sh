# name: My user
# position: 10
# description: Sets up a user for you.
# fields:
#   MY_USER:
#     name: My username
#   SSH_PUBKEY:
#     name: Public SSH key
#     description: Paste this from ~/.ssh/id_rsa.pub.

status "Creating your user $MY_USER..."
useradd $MY_USER --home "/home/$MY_USER" --create-home --shell /bin/bash
addgroup $MY_USER admin

status  "Note: this user has no password."
status_ "Set one by typing 'sudo passwd $MY_USER'"

status "Setting up SSH keys..."
mkdir /home/$MY_USER/.ssh
echo $SSH_PUBKEY > /home/$MY_USER/.ssh/authorized_keys
chmod 700 /home/$MY_USER/.ssh
chmod 600 /home/$MY_USER/.ssh/authorized_keys
chown -R $MY_USER:$MY_USER /home/$MY_USER/.ssh
