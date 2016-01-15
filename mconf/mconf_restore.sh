#!/bin/bash

. /functions.sh

#backup_file=$MCONF_BACKUP_DIR/$1
backup_dir=$MCONF_BACKUP_DIR/$1

set -x 

[ ! -d $backup_dir ] && echo -e "Backup not found." && exit 1

echo -e "Restoring Mconf backup: ${backup_dir}"

tmp_dir=`mktemp -d`

#First uncompress backup file
# echo -e "Uncompressing..."
# tar jvxf $backup_dir/mconf*.bz2 -C $tmp_dir
# [ $? -gt 0 ] && echo -e "Unable to uncompress the backup file." && exit 1
# 
# cd $tmp_dir
cd $backup_dir
#set -x
#Restore database sql dump
$mysqlcmd ${MCONF_DB_NAME} -e "select * from users;" > /dev/null 2>&1
[ $? -eq 0 ] && echo -e "${MCONF_DB_NAME} database is not empty." && exit 1
echo -e "Restoring database backup..."
sql_file=`ls *.sql`
$mysqlcmd ${MCONF_DB_NAME} < "$sql_file"
[ $? -gt 0 ] && echo -e "Unable to load database backup." && exit 1

#Restore files
echo -e "Restoring files..."
tar jxf *.tar.bz2 -C /
[ $? -gt 0 ] && echo -e "Unable to uncompress the backup file."

echo -e "Done."
