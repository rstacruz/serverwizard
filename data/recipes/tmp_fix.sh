# #### BEGIN SCRIPT INFO ###
# name: Noexec /tmp fix
# description: Check this if /tmp is mounted as noexec.
# position: 5
# #### END SCRIPT INFO #####

IS_MOUNTED="`mount | grep "tmpfs on /tmp" | wc -l`"
if [ "$IS_MOUNTED" == "0" ]; then
  status "Mounting a tmpfs to /tmp..."
  mount -t tmpfs -o size=5G,nr_inodes=5k,mode=700 tmpfs /tmp
fi
