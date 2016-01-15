FROM centos/mariadb:latest
MAINTAINER "Juan Luis Baptiste" <juan.baptiste@gmail.com>
ENV MYSQL_ROOT_PASSWORD changeme
USER root
RUN yum install -y epel-release
COPY run.sh /usr/bin/
RUN chmod 755 /usr/bin/run.sh

#Use a separate volume for data.
VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306
#Call launch script
CMD ["/usr/bin/run.sh"]
