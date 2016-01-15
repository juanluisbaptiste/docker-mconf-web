# docker-mconf
Unofficial docker image for Mconf Web Conferencing Platform. This repository 
contains the Dockerfile and all other files needed to build the image and 
launch a full fledge web video conferencing platform.

More info about Mconf at: http://www.mconf.org

### Build instructions

We use `docker-compose` to build the images. Clone this repo and then:

    cd docker-mconf-web
    sudo docker-compose build

This command will build all the images and pull the missing needed ones like

[SMTP relay](https://github.com/juanluisbaptiste/docker-postfix), 
a redis container, 
a Mariadb database, 
a nginx proxy server 
and a bigblu.


### How to run it

If you don't want to build the image and just use it then you can use this other `docker-compose` file:

    sudo docker-compose -f docker-compose-prod.yml up 

By default, when the container is run it will be configured according to the `setup_conf.yml` configuration 
file. If you are building a derived image from this one you can add your own custom configuration file. If 
not you can use the following environment variables to configure the container:


There are also some other environment variables that can be set to customize
the default install:

Database configuration:

* `MCONF_DB_PASSWORD`: Mconf user database password. If it's not set the password will be randomly generated.

Mconf configuration:

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

SMTP server settings:

* `MCONF_SITE_SMTP_SERVER`
* `MCONF_SITE_SMTP_PORT`
* `MCONF_SITE_SMTP_DOMAIN`
* `MCONF_SITE_SMTP_SENDER`
* `MCONF_SITE_SMTP_USE_TLS`
* `MCONF_SITE_SMTP_AUTO_TLS`
* `MCONF_SITE_SMTP_AUTH_TYPE`

BigBlueButton server configuration:

* `MCONF_WEBCONF_NAME`
* `MCONF_WEBCONF_URL`
* `MCONF_WEBCONF_SERVER`
* `MCONF_WEBCONF_SALT`
* `MCONF_WEBCONF_VERSION`
* `MCONF_REDIS_HOST`
* `MCONF_REDIS_PORT`
* `MCONF_REDIS_DB`
* `MCONF_REDIS_PASSWORD`

However, you can load a backup or run the installer by defining one of these env variables:

* `MCONF_RESTORE=yes` Will restore the backup specified by `MCONF_RESTORE_FILE` environment variable.
* `MCONF_RESTORE_FILE` is the backup name to restore, compressed as a bz2 compressed file. Backups must be inside the */data/backups* directory (you should host mount it).

You need to mount that backups volume from somewhere, it can be from another volume (using *--volumes-from*) or mounting 
a host volume which contains the backup files.



For testing the containers you can bring them up with `docker-compose`:

    sudo docker-compose build
    sudo docker-compose up

This will bring up all needed containers, link them and mount volumes according 
to the `docker-compose.yml` configuration file. 

The default database password is `changeme`, to change it, edit the `docker-compose.yml` file and change the 
`MYSQL_ROOT_PASSWORD` environment variable on the `mariadb` image definition before 
running `docker-compose`.

To start the containers in production mode use this [`docker-compose.yml`](https://github.com/juanluisbaptiste/docker-otrs/blob/master/docker-compose-prod.yml) file that points to images to be pulled and run instead of Dockerfiles being built:

    sudo docker-compose -f docker-compose-prod.yml -p companyotrs up -d

After the containers finish starting up you can access the OTRS system at the following
addresses:
