# APP_ROOT = "/var/www/myapp/current"
#
# God.watch do |w|
#   w.name = "unicorn-sample"
#   w.interval = 30.seconds
#
#   w.start = "cd #{APP_ROOT} && /usr/local/bin/unicorn -c #{APP_ROOT}/config/unicorn.rb -E production -D"
# 
#   # QUIT gracefully shuts down workers
#   w.stop = "kill -QUIT `cat #{APP_ROOT}/tmp/pids/unicorn.pid`"
# 
#   # USR2 causes the master to re-create itself and spawn a new worker pool
#   w.restart = "kill -USR2 `cat #{APP_ROOT}/tmp/pids/unicorn.pid`"
# 
#   w.start_grace = 10.seconds
#   w.restart_grace = 10.seconds
#   w.pid_file = "#{APP_ROOT}/tmp/pids/unicorn.pid"
#
#   # w.uid = "uidname"
#   # w.gid = "gidname"
#
#   w.behavior(:clean_pid_file)
# 
#   w.restart_if do |restart|
#     restart.condition(:memory_usage) do |c|
#       c.above = 300.megabytes
#       c.times = [3, 5]
#     end
# 
#     restart.condition(:cpu_usage) do |c|
#       c.above = 50.percent
#       c.times = 5
#     end
#   end
# end
