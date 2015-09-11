#!/bin/bash
# Startup script for this Mconf container. 
#
# The script by default loads a fresh Mconf install ready to be used. 
#


. /functions.sh

wait_for_database

echo -e "\n\e[92mStarting \e[0m Mconf \e[92mWeb Conferencing Platform !!\n\e[0m"

if [ ! -z $BBB_ENV_SERVER_NAME ]; then
  echo -e "Found linked BigBlueButton container, setting MCONF_WEBCONF_SERVER to: $BBB_ENV_SERVER_NAME" && MCONF_WEBCONF_SERVER=$BBB_ENV_SERVER_NAME
  #We map BBB_ENV_SERVER_NAME to the IP address of the linked container so it
  #doesn't resolve to the public IP address which isn't reachable from the container
  sudo bash -c "printf '%s\t%s\n' $BBB_PORT_80_TCP_ADDR $BBB_ENV_SERVER_NAME | cat >> /etc/hosts"
fi
[ ! -z $BBB_ENV_SERVER_SALT ] && echo -e "Found linked BigBlueButton container, setting MCONF_WEBCONF_SALT to: $BBB_ENV_SERVER_SALT" && MCONF_WEBCONF_SALT=$BBB_ENV_SERVER_SALT

if [ "$MCONF_RESTORE" == "yes" ];then
  create_db
  restore_backup
else
  load_defaults
  #Finish mconf installation
  cd /var/www/mconf-web/
  RAILS_ENV=production bundle exec rake db:drop db:create db:reset
  RAILS_ENV=production bundle exec rake secret:reset
fi
bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile
set_virtualhost_name "ServerName" $MCONF_SITE_DOMAIN
[ "$MCONF_DISABLE_REGISTRATION" == "yes" ] && disable_registration

#Launch supervisord
echo -e "Starting supervisord..."
sudo supervisord -c /etc/supervisor/supervisord.conf