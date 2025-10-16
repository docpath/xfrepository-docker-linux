#!/bin/bash


config_file='/usr/local/docpath/xfservicepack/xfservice/Configuration/xfservice.ini'
db_type="${DB_TYPE:-MySQL}"
db_host="${DB_HOST:-localhost}"
db_port="${DB_PORT:-3306}"
db_user="${DB_USER:-root}"
db_pass="${DB_PASS:-root}"
db_name="${DB_NAME:-xfrepository}"
aim_url="${AIM_URL}"
aim_token="${AIM_TOKEN}"
license_address="${LICENSE_ADDRESS:-localhost}"
license_port="${LICENSE_PORT:-1765}"
transaction_id="${TRANSACTION_ID}"
shutdown_session="${SHUTDOWN_SESSION}"
local_user="${LOCAL_USER:-admin}"
local_user_pass="${LOCAL_USER_PASS:-admin}"

echo "[log]" > "$config_file"
echo "log level = info" >> "$config_file"
echo "log mode = file" >> "$config_file"
echo "log file name = xfservice.log" >> "$config_file"
echo "log max file = 3" >> "$config_file"
echo "log max size = 10MB" >> "$config_file"
echo "log remove = false" >> "$config_file"
echo "log server = localhost" >> "$config_file"
echo "log port = 1514" >> "$config_file"
echo "[main]" >> "$config_file"
echo "port = 1818" >> "$config_file"
echo "host ip = host_auto_ipv4" >> "$config_file"
echo "disable https = true" >> "$config_file"
echo "disable qpd file compression = false" >> "$config_file"
echo "disable qdf file compression = false" >> "$config_file"
echo "disable qfs file compression = false" >> "$config_file"
echo "admin token expiration = 24hrs" >> "$config_file"
echo "frequency of checking unused connections = 30mins" >> "$config_file"
echo "[license]" >> "$config_file"
echo "port = $license_port" >> "$config_file"
echo "address = $license_address" >> "$config_file"
echo "[local user]" >> "$config_file"
echo "username = $local_user" >> "$config_file"
echo "pass = $local_user_pass" >> "$config_file"
echo "[aim]" >> "$config_file"
echo "url = $aim_url" >> "$config_file"
echo "app token = $aim_token" >> "$config_file"
echo "[database]" >> "$config_file"
echo "type = $db_type" >> "$config_file"
echo "server = $db_host" >> "$config_file"
echo "port = $db_port" >> "$config_file"
echo "name = $db_name" >> "$config_file"
echo "user = $db_user" >> "$config_file"
echo "password = $db_pass" >> "$config_file"
echo "secure connection = false" >> "$config_file"

cd /usr/local/docpath/licenseserver/licenseserver/Bin
./startServer.sh

sleep 5

cd /usr/local/docpath/xfservicepack/xfservice/Bin
if [[ -n $transaction_id ]]
then
    exec java -jar xfservice.war -logmodeconsole -licensetransactionid$transaction_id -licenseaddr$license_address -licenseport$license_port -licenseshutdownsession$shutdown_session
else 
    exec java -jar xfservice.war -logmodeconsole
fi