# name: Change host name
# description: Changes the hostname of the server.
# position: 10
# fields:
#   HOST_NAME: Host name (text)

status "Changing hostname to '$HOST_NAME'..."
echo "127.0.1.1 $HOST_NAME" >> /etc/hosts
echo $HOST_NAME > /etc/hostname

# Note 1: 'service hostname restart' doesn't work.
# Note 2: Ubuntu complains about this, so let's supress it.
/etc/init.d/hostname restart 2>&1 >/dev/null

status "Note: Hostname was changed, but you may need to log back in for it to see it."