#!/bin/bash

. /functions.sh

DATE=`date +'%m-%d-%Y_%H-%M'`
MCONF_BACKUP_DIR="${MCONF_BACKUP_DIR}/$DATE"
MCONF_BACKUP_FILE="${MCONF_BACKUP_DIR}/mconf-backup-${DATE}.tar"

mkdir -p ${MCONF_BACKUP_DIR}
echo -e "Backing up database..."
$mysqldumpcmd --databases ${MCONF_DB_NAME} > "${MCONF_BACKUP_DIR}/${MCONF_DB_NAME}-${DATE}.sql"

echo -e "Backing up files..."
[ -d ${MCONF_ROOT}log/ ] && tar cvf "$MCONF_BACKUP_FILE" ${MCONF_ROOT}log/
[ -d ${MCONF_ROOT}private/attachments/ ] && tar rvf -C "$MCONF_BACKUP_FILE" ${MCONF_ROOT}private/
[ -d ${MCONF_ROOT}public/uploads/ ] && tar rvf -C "$MCONF_BACKUP_FILE" ${MCONF_ROOT}public/uploads/
bzip2 $MCONF_BACKUP_FILE

echo -e "Done."
