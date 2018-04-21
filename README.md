# docker-mconf
Unofficial docker image for Mconf Web Conferencing Platform for [BigBlueButton](http://www.BigBlueButton.org).

This repository contains the Dockerfile and all other files needed to build the
image and launch a full blown web video conferencing platform. More info about \
Mconf can be found at: http://www.mconf.org

### Build instructions

We use `docker-compose` to build and run the images. Clone this repo and then:

    cd docker-mconf-web
    sudo docker-compose build

### How to run it

If you don't want to build the image and just use the images available at docker hub then
you can use this other [`docker-compose.yml`](https://github.com/juanluisbaptiste/docker-mconf-web/blob/master/docker-compose-prod.yml)
file, and bring up the containers like this:

    sudo docker-compose -f docker-compose-prod.yml up

Upon container startup, the images of other needed container will be pulled, like:

   [SMTP relay](https://github.com/juanluisbaptiste/docker-postfix),
   a redis container,
   a Mariadb database,
   a [nginx proxy](https://github.com/jwilder/nginx-proxy) server,
   and a [bigbluebutton server](https://github.com/juanluisbaptiste/docker-bigbluebutton).

By default, when the Mconf container is run it will be configured according to the
`setup_conf.yml` configuration file. The database configuration file `database.yml`
is already configured to use the included `mariadb` container, it only needs to be
configured if you plan to use another database.

If you are building a derived image from this one you can add your own custom
configuration file in the `Dockerfile`, copying them to `/var/www/mconf-web/config/`. If
not you can use the following environment variables to configure the container
in the file `docker-compose.yml`:

#### Database configuration:

* `MCONF_DB_PASSWORD`: Mconf user database password. By default is set to `changeme`.
* `MYSQL_ROOT_PASSWORD`: database root user password needed to create the database
and fill it up. Default password is also `changeme`, to change it, change it on the
`mariadb` service definition (look at the `docker-compose.yml` files for an example).

#### Mconf configuration:

* `MCONF_ADMIN_USERNAME`
* `MCONF_ADMIN_EMAIL`
* `MCONF_ADMIN_PASSWORD`
* `MCONF_ADMIN_NAME`
* `MCONF_SITE_NAME`
* `MCONF_SITE_DESC`
* `MCONF_SITE_LOCALE` available languages are *en*, *es-419* and *pt-br* (default is *en*).
* `MCONF_SITE_DOMAIN`
* `MCONF_SITE_FEEDBACK_URL`
* `MCONF_SITE_ANALYTICS_CODE`
* `MCONF_SITE_SIGNATURE`
* `MCONF_SITE_SSL`
* `MCONF_DISABLE_REGISTRATION` Disable user registration.

#### SMTP server settings:

We use a [SMTP Relay container](https://github.com/juanluisbaptiste/docker-postfix) to
send notification emails. This only need to be set if the included postfix container
isn't used.

* `MCONF_SITE_SMTP_SERVER`
* `MCONF_SITE_SMTP_PORT`
* `MCONF_SITE_SMTP_DOMAIN`
* `MCONF_SITE_SMTP_SENDER`
* `MCONF_SITE_SMTP_USE_TLS`
* `MCONF_SITE_SMTP_AUTO_TLS`
* `MCONF_SITE_SMTP_AUTH_TYPE`

#### BigBlueButton server configuration:

* `MCONF_WEBCONF_NAME` Name for the BigBlueButton server.
* `MCONF_WEBCONF_SERVER` BigBlueButton server hostname.
* `MCONF_WEBCONF_SALT` Salt of the BigBlueButton server.
* `MCONF_WEBCONF_VERSION` version of the BigBlueButton server. This one is optional.

If there's linked a BigBlueButton container then there's no need to set MCONF_WEBCONF_SERVER
as mconf will be automatically configured to use the linked container.

We also include a `redis` container so the following variables only need to be set
if you plan to use a different one:

* `MCONF_REDIS_HOST`
* `MCONF_REDIS_PORT`
* `MCONF_REDIS_DB`
* `MCONF_REDIS_PASSWORD`

The default database password is `changeme`, to change it, edit the `docker-compose.yml`
file and change the `MYSQL_ROOT_PASSWORD` environment variable on the `mariadb`
image definition before running `docker-compose`.

#### Using docker hub images

Use this [`docker-compose.yml`](https://github.com/juanluisbaptiste/docker-mconf-web/blob/master/docker-compose-prod.yml)
file that points to pre-built images to be pulled from docker hub and run instead of
building them:

    sudo docker-compose -f docker-compose-prod.yml up

This docker compose file will pull all needed pieces as mentioned before, including
the proxy container. This one is needed to be able to run both mconf-web and the
BigBlueButton container on the same host. The proxy is based on [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)
and increases `client_max_body_size=10m` to allow bigger presentation uploads. To
use it we need to define an environment variable called VIRTUAL_HOST on the mconf
and BigBlueButton services with the DNS hostname of each of them as their value. By
default default VIRTUAL_HOST is set to mconf.example.com and bbb.example.com
respectively.

After the containers finish starting up you can access the Mconf portal at:

http://meet.example.com

or whatever other hostname you specified on the VIRTUAL_HOST environment variables
for `mconf-web` and `BigBlueButton` services. If you are just testing you could add
`mconf.example.com` and `bbb.example.com` to your `/etc/hosts` file pointing to your
docker machine and test it.


### Backing up and restoring

I have included backup and restore scripts to backup an mconf install including
the database contents. Scripts are still very basic, there's lots of room for
improvement. `Use them at your own risk.`

#### Backing up

On a running Mconf container exec the following script:

    sudo docker exec mconfweb_mconf_1 /mconf_backup.sh

The backup script will create a tarball and copy it to `/data/backups` which you
can host mount to have access to the backup files from the docker host. The
backup directory can be changed with the MCONF_BACKUP_DIR environment variable.

#### Restoring

To restore a backup file created with the previous backup script, two environment
variables need to be set:

* `MCONF_RESTORE=yes` Will restore the backup specified by `MCONF_RESTORE_FILE`
environment variable.
* `MCONF_RESTORE_FILE` is the backup name to restore, compressed as a bz2 file.
Backups must be inside the `/data/backups` directory.

You need to mount that backups volume from somewhere, it can be from another volume
(using *--volumes-from*) or mounting a host volume which contains the backup files.
