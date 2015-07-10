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
# - MCONF_ROOT_PASSWORD to set the admin user 'root@localhost' password. 
#
#env
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
  [ -z "${MCONF_HOSTNAME}" ] && MCONF_HOSTNAME="otrs-`random_string`" && echo "MCONF_ROOT_HOSTNAME not set, setting hostname to '$MCONF_HOSTNAME'"
  [ -z "${MCONF_ADMIN_EMAIL}" ] && echo "MCONF_ADMIN_EMAIL not set, setting admin email to '$DEFAULT_MCONF_ADMIN_EMAIL'" && MCONF_ADMIN_EMAIL=$DEFAULT_MCONF_ADMIN_EMAIL
  [ -z "${MCONF_DB_PASSWORD}" ] && MCONF_DB_PASSWORD=`random_string` && echo "MCONF_DB_PASSWORD not set, setting password to '$MCONF_DB_PASSWORD'"
  [ -z "${MCONF_ROOT_PASSWORD}" ] && echo "MCONF_ROOT_PASSWORD not set, setting password to '$DEFAULT_MCONF_PASSWORD'" && MCONF_ROOT_PASSWORD=$DEFAULT_MCONF_PASSWORD
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

function set_fetch_email_time(){
  if [ ! -z $MCONF_POSTMASTER_FETCH_TIME ]; then
    echo -e "Setting Postmaster fetch emails time to \e[92m$MCONF_POSTMASTER_FETCH_TIME\e[0m minutes"
    /opt/mconf/scripts/otrs_postmaster_time.sh $MCONF_POSTMASTER_FETCH_TIME
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
    if [ -e "/opt/otrs/var/tmp/firsttime" ]; then
      #Load default install
      echo -e "\n\e[92mStarting a clean\e[0m Mconf \e[92minstallation ready to be configured !!\n\e[0m"
      load_defaults
      #Set default admin user password
      echo -e "Setting password for default admin account root@localhost..."
      /opt/otrs/bin/otrs.SetPassword.pl --agent root@localhost $MCONF_ROOT_PASSWORD
      rm -fr /opt/otrs/var/tmp/firsttime
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