#!/bin/bash
# Startup script for this Mconf container. 
#
# The script by default loads a fresh Mconf install ready to be customized through 
# the admin web interface. 
#
# If the environment variable MCONF_INSTALL is set to yes, then the default web 
# installer can be run from localhost/otrs/installer.pl.
#
# If the environment variable MCONF_INSTALL="restore", then the configuration backup 
# files will be loaded from /opt/otrs/backups. This means you need to build 
# the image with the backup files (sql and Confg.pm) you want to use, or, mount a 
# host volume to map where you store the backup files to /opt/otrs/backups.
#
# To change the default database and admin interface user passwords you can define 
# the following env vars too:
# - MCONF_DB_PASSWORD to set the database password
#
source /home/mconf/.bash_profile

DEFAULT_MCONF_ADMIN_EMAIL="admin@example.com"
MCONF_BACKUP_DIR="/var/mconf/backups"

[ -z "${MCONF_INSTALL}" ] && MCONF_INSTALL="no"

mysqlcmd="mysql -uroot -h $MARIADB_PORT_3306_TCP_ADDR -p$MARIADB_ENV_MYSQL_ROOT_PASSWORD "

function create_db(){
  echo -e "Creating Mconf database..."
  $mysqlcmd -e "CREATE DATABASE IF NOT EXISTS mconf;"
  [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't create Mconf database !!\n" && exit 1
  $mysqlcmd -e " GRANT ALL ON mconf.* to 'mconf'@'%' identified by '$MCONF_DB_PASSWORD'";
  [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't create database user !!\n" && exit 1
}  

function restore_backup(){
  [ -z $1 ] && echo -e "\n\e[1;31mERROR:\e[0m MCONF_BACKUP_DATE not set.\n" && exit 1
  set_variables
  copy_default_config
  create_db
  update_config_password $MCONF_DB_PASSWORD
  
  #Run restore backup command
  /opt/otrs/scripts/restore.pl -b $MCONF_BACKUP_DIR/$1 -d /opt/otrs/
  [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't load Mconf backup !!\n" && exit 1
  
  #Restore configured password overwritten by restore
  update_config_password $MCONF_DB_PASSWORD
}

function random_string(){
  echo `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1`
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
  [ ! -z "${MCONF_WEBCONF_URL}" ] && echo "MCONF_WEBCONF_URL set to '$MCONF_WEBCONF_URL'" && set_variable "webconf_server" "url" "$MCONF_WEBCONF_URL"
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
  cd /var/www/mconf-web/config
  sed -i -r "/$section:$/,/^\[/ s/($var: *\").*/\1$value\"/" setup_conf.yml
}

function load_defaults(){
  set_variables

  #Check if database doesn't exists yet (it could if this is a container redeploy)
  $mysqlcmd -e 'use mconf'
  if [ $? -gt 0 ]; then
    create_db
    #Check that a backup isn't being restored
    if [ "$MCONF_INSTALL" == "no" ]; then
      echo -e "Loading default db schema..."
      $mysqlcmd otrs < /opt/mconf/scripts/database/default-install.mysql.sql
      [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't load Mconf database schema !!\n" && exit 1
      echo -e "Loading initial db inserts..."
      $mysqlcmd otrs < /opt/otrs/scripts/database/otrs-initial_insert.mysql.sql
      [ $? -gt 0 ] && echo -e "\n\e[1;31mERROR:\e[0m Couldn't load Mconf database initial inserts !!\n" && exit 1
    fi
  fi
}

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

#If MCONF_INSTALL isn't defined load a default install
if [ "$MCONF_INSTALL" != "yes" ]; then
  if [ "$MCONF_INSTALL" == "no" ]; then
    if [ -e "/opt/mconf/var/tmp/firsttime" ]; then
      #Load default install
      echo -e "\n\e[92mStarting a clean\e[0m Mconf \e[92minstallation ready to be configured !!\n\e[0m"
      load_defaults
      rm -fr /opt/mconf/var/tmp/firsttime
    fi  
  # If MCONF_INSTALL == restore, load the backup files in /opt/otrs/backups
  elif [ "$MCONF_INSTALL" == "restore" ];then
    echo -e "\n\e[92mRestoring \e[0m Mconf \e[92m backup: \n\e[0m"
    restore_backup $MCONF_BACKUP_DATE
  fi
else
  #If neither of previous cases is true the installer will be run.
  echo -e "\n\e[92mStarting \e[0m Mconf \e[92minstaller !!\n\e[0m"
  load_defaults
  #Finish mconf installation
  cd /var/www/mconf-web/
  RAILS_ENV=production bundle exec rake db:drop db:create db:reset
  RAILS_ENV=production bundle exec rake secret:reset
  bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile

fi

#Launch supervisord
echo -e "Starting supervisord..."
sudo supervisord -c /etc/supervisor/supervisord.conf