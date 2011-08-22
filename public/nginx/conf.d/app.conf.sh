cat <<END
server {
    listen 80;
    server_name $APP_DOMAIN;
    passenger_enabled on;
    rack_env production;
    root $APP_REPO_PATH/public;
    access_log $APP_LOGS_PATH/access.log;
    error_log  $APP_LOGS_PATH/error.log;
}
END
