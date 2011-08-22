echo "#user nobody;
worker_processes 1;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    passenger_root $PASSENGER_ROOT;
    passenger_ruby `which ruby`;
    passenger_max_pool_size 6;
    passenger_max_instances_per_app 0;
    
    include mime.types;
    default_type application/octet-stream;
    sendfile on;
    keepalive_timeout 65;
    
    include /opt/nginx/conf/conf.d/*.conf;
}"
