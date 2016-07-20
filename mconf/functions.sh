#!/bin/bash
# Startup script for this Mconf container. 
#
# The script by default loads a fresh Mconf install ready to be used. 
#

source /home/mconf/.bash_profile

DEFAULT_MCONF_ADMIN_EMAIL="admin@example.com"
MCONF_BACKUP_DIR="/data/backups"

[ -z "${MCONF_INSTALL}" ] && MCONF_INSTALL="no"

mysql_params="-uroot -h $MARIADB_PORT_3306_TCP_ADDR -p$MARIADB_ENV_MYSQL_ROOT_PASSWORD "
mysqlcmd="mysql $mysql_params"
mysqldumpcmd="mysqldump $mysql_params"

function wait_for_database(){
  while true; do
    out="`$mysqlcmd -e "SELECT COUNT(*) FROM mysql.user;" 2>&1`"
    echo -e $out
    echo "$out" | grep "COUNT"
    if [ $? -eq 0 ]; then
      echo -e "\n\e[92mServer is up !\e[0m\n"
      break
    fi
    echo -e "\nDB server still isn't up, sleeping a little bit ...\n"
    sleep 2
  done
}

function create_db(){
  echo -e "Creating Mconf database..."
  $mysqlcmd -e "CREATE DATABASE IF NOT EXISTS ${MCONF_DB_NAME};"
  [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't create Mconf database !!\n" && exit 1
  $mysqlcmd -e " GRANT ALL ON ${MCONF_DB_NAME}.* to 'mconf'@'%' identified by '$MCONF_DB_PASSWORD'";
  [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't create database user !!\n" && exit 1
}  

# function restore_backup(){
# 
# }

function random_string(){
  echo `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 33 | head -n 1`
}

function set_variables(){
  [ -z "${MCONF_DB_PASSWORD}" ] && MCONF_DB_PASSWORD=`random_string` && echo "MCONF_DB_PASSWORD not set, setting password to '$MCONF_DB_PASSWORD'"
  [ ! -z "${MCONF_ADMIN_USERNAME}" ] && echo "MCONF_ADMIN_USERNAME set to '$MCONF_ADMIN_USERNAME'" && set_variable "admin" "username" $MCONF_ADMIN_USERNAME
  [ ! -z "${MCONF_ADMIN_EMAIL}" ] && echo "MCONF_ADMIN_EMAIL set to '$MCONF_ADMIN_EMAIL'" && set_variable "admin" "email" $MCONF_ADMIN_EMAIL
  [ ! -z "${MCONF_ADMIN_PASSWORD}" ] && echo "MCONF_ADMIN_PASSWORD set to '$MCONF_ADMIN_PASSWORD'" && set_variable "admin" "password" $MCONF_ADMIN_PASSWORD
  [ ! -z "${MCONF_ADMIN_NAME}" ] && echo "MCONF_ADMIN_NAME set to '$MCONF_ADMIN_NAME'" && set_variable "admin" "full_name" "$MCONF_ADMIN_NAME"
  [ ! -z "${MCONF_SITE_NAME}" ] && echo "MCONF_SITE_NAME set to '$MCONF_SITE_NAME'" && set_variable "site" "name" "$MCONF_SITE_NAME"
  [ ! -z "${MCONF_SITE_DESC}" ] && echo "MCONF_SITE_DESC set to '$MCONF_SITE_DESC'" && set_variable "site" "description" "$MCONF_SITE_DESC"
  [ ! -z "${MCONF_SITE_LOCALE}" ] && echo "MCONF_SITE_LOCALE set to '$MCONF_SITE_LOCALE'" && set_variable "site" "locale" $MCONF_SITE_LOCALE
  [ ! -z "${MCONF_SITE_DOMAIN}" ] && echo "MCONF_SITE_DOMAIN set to '$MCONF_SITE_DOMAIN'" && set_variable "site" "domain" $MCONF_SITE_DOMAIN
  [ ! -z "${MCONF_SITE_FEEDBACK_URL}" ] && echo "MCONF_SITE_FEEDBACK_URL set to '$MCONF_SITE_FEEDBACK_URL'" && set_variable "site" "feedback_url" $MCONF_SITE_FEEDBACK_URL
  [ ! -z "${MCONF_SITE_ANALYTICS_CODE}" ] && echo "MCONF_SITE_ANALYTICS_CODE set to '$MCONF_SITE_ANALYTICS_CODE'" && set_variable "site" "analytics_code" $MCONF_SITE_ANALYTICS_CODE
  [ ! -z "${MCONF_SITE_SMTP_SERVER}" ] && echo "MCONF_SITE_SMTP_SERVER set to '$MCONF_SITE_SMTP_SERVER'" && set_variable "site" "smtp_server" $MCONF_SITE_SMTP_SERVER
  [ ! -z "${MCONF_SITE_SMTP_PORT}" ] && echo "MCONF_SITE_SMTP_PORT set to '$MCONF_SITE_SMTP_PORT'" && set_variable "site" "smtp_port" $MCONF_SITE_SMTP_PORT
  [ ! -z "${MCONF_SITE_SMTP_DOMAIN}" ] && echo "MCONF_SITE_SMTP_DOMAIN set to '$MCONF_SITE_SMTP_DOMAIN'" && set_variable "site" "smtp_domain" $MCONF_SITE_SMTP_DOMAIN
  [ ! -z "${MCONF_SITE_SMTP_SENDER}" ] && echo "MCONF_SITE_SMTP_SENDER set to '$MCONF_SITE_SMTP_SENDER'" && set_variable "site" "smtp_sender" $MCONF_SITE_SMTP_SENDER
  [ ! -z "${MCONF_SITE_SMTP_USE_TLS}" ] && echo "MCONF_SITE_SMTP_USE_TLS set to '$MCONF_SITE_SMTP_USE_TLS'" && set_variable "site" "smtp_use_tls" $MCONF_SITE_SMTP_USE_TLS
  [ ! -z "${MCONF_SITE_SMTP_AUTO_TLS}" ] && echo "MCONF_SITE_SMTP_AUTO_TLS set to '$MCONF_SITE_SMTP_USE_TLS'" && set_variable "site" "smtp_auto_tls" $MCONF_SITE_SMTP_AUTO_TLS
  [ ! -z "${MCONF_SITE_SMTP_AUTH_TYPE}" ] && echo "MCONF_SITE_SMTP_AUTH_TYPE set to '$MCONF_SITE_SMTP_USE_TLS'" && set_variable "site" "smtp_auth_type" $MCONF_SITE_SMTP_AUTH_TYPE
  [ ! -z "${MCONF_SITE_SIGNATURE}" ] && echo "MCONF_SITE_SIGNATURE set to '$MCONF_SITE_SIGNATURE'" && set_variable "site" "signature" "$MCONF_SITE_SIGNATURE"
  [ ! -z "${MCONF_SITE_SSL}" ] && echo "MCONF_SITE_SSL set to '$MCONF_SITE_SSL'" && set_variable "site" "ssl" $MCONF_SITE_SSL
  [ ! -z "${MCONF_WEBCONF_NAME}" ] && echo "MCONF_WEBCONF_NAME set to '$MCONF_WEBCONF_NAME'" && set_variable "webconf_server" "name" "$MCONF_WEBCONF_NAME"
#  [ ! -z "${MCONF_WEBCONF_URL}" ] && echo "MCONF_WEBCONF_URL set to '$MCONF_WEBCONF_URL'" && set_variable "webconf_server" "url" "$MCONF_WEBCONF_URL"
  [ ! -z "${MCONF_WEBCONF_SERVER}" ] && echo "MCONF_WEBCONF_SERVER set to '$MCONF_WEBCONF_SERVER'" && set_variable "webconf_server" "url" "http:\/\/$MCONF_WEBCONF_SERVER\/bigbluebutton\/api"
  [ ! -z "${MCONF_WEBCONF_SALT}" ] && echo "MCONF_WEBCONF_SALT set to '$MCONF_WEBCONF_SALT'" && set_variable "webconf_server" "salt" "$MCONF_WEBCONF_SALT"
  [ ! -z "${MCONF_WEBCONF_VERSION}" ] && echo "MCONF_WEBCONF_VERSION set to '$MCONF_WEBCONF_VERSION'" && set_variable "webconf_server" "version" "$MCONF_WEBCONF_VERSION"
  [ ! -z "${MCONF_REDIS_HOST}" ] && echo "MCONF_REDIS_HOST set to '$MCONF_REDIS_HOST'" && set_variable "redis" "host" "$MCONF_REDIS_HOST"
  [ ! -z "${MCONF_REDIS_PORT}" ] && echo "MCONF_REDIS_PORT set to '$MCONF_REDIS_PORT'" && set_variable "redis" "port" "$MCONF_REDIS_PORT"
  [ ! -z "${MCONF_REDIS_DB}" ] && echo "MCONF_REDIS_DB set to '$MCONF_REDIS_DB'" && set_variable "redis" "db" "$MCONF_REDIS_DB"
  [ ! -z "${MCONF_REDIS_PASSWORD}" ] && echo "MCONF_REDIS_PASSWORD set to '$MCONF_REDIS_PASSWORD'" && set_variable "redis" "password" "$MCONF_REDIS_PASSWORD"
}

function set_variable(){
  local section=$1
  local var=$2
  local value=$3
  cd ${MCONF_ROOT}config
  sed -i -r "/$section:$/,/^\[/ s/($var: *\").*/\1$value\"/" setup_conf.yml
}

function set_virtualhost_name(){
  local option=$1
  local value=$2
  sudo sed -i -r "s/($option * *).*/\1$value/" /etc/apache2/sites-available/mconf-web.conf
}

function load_defaults(){
  set_variables

  #Check if database doesn't exists yet (it could if this is a container redeploy)
  $mysqlcmd -e "use ${MCONF_DB_NAME}"
  if [ $? -gt 0 ]; then
    create_db
  fi
}

function disable_registration(){ 
  echo -e "Disabling user registration."
  $mysqlcmd -e "update ${MCONF_DB_NAME}.sites set registration_enabled=0;"
  [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't disable user registration !!\n"
}

function restore_backup(){
  set -x
  /mconf_restore.sh $MCONF_RESTORE_FILE
}