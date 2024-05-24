#!/bin/bash


bbdd_conf='/usr/local/docpath/xfservicepack/xfservice/Configuration/xfservice.ini'
db_type="${DB_TYPE-'MySQL'}"
db_host="${DB_HOST-'localhost'}"
db_port="${DB_PORT-'3306'}"
db_user="${DB_USER-'root'}"
db_pass="${DB_PASS-'root'}"
db_name="${DB_NAME-'xfrepository'}"
aim_url="${AIM_URL}"
aim_token="${AIM_TOKEN}"
license_address="${LICENSE_ADDRESS}"
license_port="${LICENSE_PORT}"
transaction_id="${TRANSACTION_ID}"
shutdown_session="${SHUTDOWN_SESSION}"

echo '[log]' > "$bbdd_conf"
echo 'log level = info' >> "$bbdd_conf"
echo 'log mode = file' >> "$bbdd_conf"
echo 'log file name = dpesiservice.log' >> "$bbdd_conf"
echo 'log max file = 3' >> "$bbdd_conf"
echo 'log max size = 10MB' >> "$bbdd_conf"
echo 'log remove = false' >> "$bbdd_conf"
echo 'log server = localhost' >> "$bbdd_conf"
echo 'log port = 1514' >> "$bbdd_conf"
echo '[license]' >> "$bbdd_conf"
echo 'port = 1765' >> "$bbdd_conf"
echo 'address = localhost' >> "$bbdd_conf"
echo '[aim]' >> "$bbdd_conf"
echo "url = $aim_url" >> "$bbdd_conf"
echo "app token = $aim_token" >> "$bbdd_conf"
echo '[database]' >> "$bbdd_conf"
echo "type = $db_type" >> "$bbdd_conf"
echo "server = $db_host" >> "$bbdd_conf"
echo "port = $db_port" >> "$bbdd_conf"
echo "name = $db_name" >> "$bbdd_conf"
echo "user = $db_user" >> "$bbdd_conf"
echo "password = $db_pass" >> "$bbdd_conf"
echo "secure connection = false" >> "$bbdd_conf"

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