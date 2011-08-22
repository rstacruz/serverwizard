# name: My user
# position: 10
# description: Sets up a user for you.
# fields:
#   MY_USER: "My username (text)"
#   SSH_PUBKEY: "Public SSH key (textarea)"
#
status "Creating your user $MY_USER..."
sudo useradd $MY_USER --home "/home/$MY_USER" --create-home
sudo addgroup $MY_USER admin

status "Note: this user has no password."
status "Set one by typing 'sudo passwd $MY_USER'"

status "Setting up SSH keys..."
sudo mkdir /home/$MY_USER/.ssh
echo $SSH_PUBKEY > /home/$MY_USER/.ssh/authorized_keys
sudo chmod 700 /home/$MY_USER/.ssh
sudo chmod 600 /home/$MY_USER/.ssh/authorized_keys
sudo chown -R $MY_USER:$MY_USER /home/$MY_USER/.ssh
