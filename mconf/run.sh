#!/bin/bash
# Startup script for this Mconf container. 
#
# The script by default loads a fresh Mconf install ready to be used. 
#


. /functions.sh

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

#If neither of previous cases is true the installer will be run.
echo -e "\n\e[92mStarting \e[0m Mconf \e[92mWeb Conferencing Platform !!\n\e[0m"
load_defaults
#Finish mconf installation
cd /var/www/mconf-web/
RAILS_ENV=production bundle exec rake db:drop db:create db:reset
RAILS_ENV=production bundle exec rake secret:reset
bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile
set_virtualhost_name "ServerName" $MCONF_SITE_DOMAIN
[ "$MCONF_DISABLE_REGISTRATION" == "yes" ] && disable_registration

#Launch supervisord
echo -e "Starting supervisord..."
sudo supervisord -c /etc/supervisor/supervisord.conf