#!/bin/bash

. /functions.sh

DATE=`date +'%m-%d-%Y_%H-%M'`
MCONF_BACKUP_DIR="${MCONF_BACKUP_DIR}/$DATE"
MCONF_BACKUP_FILE="${MCONF_BACKUP_DIR}/mconf-backup-${DATE}.tar.bz2"
MCONF_BACKUP_DATA_FILE="${MCONF_BACKUP_DIR}/mconf-backup_data-${DATE}.tar"

mkdir -p ${MCONF_BACKUP_DIR}
[ $? -gt 0 ] && echo -e "Could not create backup directory." && exit 1
echo -e "Backing up database..."
$mysqldumpcmd --databases ${MCONF_DB_NAME} > "${MCONF_BACKUP_DIR}/${MCONF_DB_NAME}-${DATE}.sql"
[ $? -gt 0 ] && echo -e "Could not load database backup." && exit 1

echo -e "Backing up data files..."
[ -d ${MCONF_ROOT}log/ ] && tar cf "$MCONF_BACKUP_DATA_FILE" ${MCONF_ROOT}log/ -C $MCONF_BACKUP_DIR
[ -d ${MCONF_ROOT}private/attachments/ ] && tar rf "$MCONF_BACKUP_DATA_FILE" ${MCONF_ROOT}private/attachments/ -C $MCONF_BACKUP_DIR
[ -d ${MCONF_ROOT}public/uploads/ ] && tar rf "$MCONF_BACKUP_DATA_FILE" ${MCONF_ROOT}public/uploads/ -C $MCONF_BACKUP_DIR
[ -d ${MCONF_ROOT}private/uploads/ ] && tar rf "$MCONF_BACKUP_DATA_FILE" ${MCONF_ROOT}private/uploads/ -C $MCONF_BACKUP_DIR
[ -e $MCONF_BACKUP_DATA_FILE ] && echo -e "Compressing file..." && bzip2 $MCONF_BACKUP_DATA_FILE
[ $? -gt 0 ] && echo -e "Could not compress backup file." && exit 1

#echo -e "Backing up application files..."
#tar jcvf "$MCONF_BACKUP_FILE" --exclude="${MCONF_ROOT}*.git/*" --exclude="${MCONF_ROOT}log/*" --exclude="${MCONF_ROOT}private/attachments/*" --exclude="${MCONF_ROOT}public/uploads/*" --exclude="${MCONF_ROOT}public/assets/*" --exclude="${MCONF_ROOT}tmp/*"  ${MCONF_ROOT}
#[ $? -gt 0 ] && echo -e "Could not compress backup file." && exit 1
echo -e "Done."

