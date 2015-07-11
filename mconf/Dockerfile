FROM ubuntu:14.04
MAINTAINER Juan Luis Baptiste juan.baptiste@gmail.com
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get install -y apache2 apache2-prefork-dev libapr1-dev libaprutil1-dev \
    libcurl4-openssl-dev libapache2-mod-xsendfile wget make curl \ 
    git-core libruby aspell-es aspell-en libxml2-dev \
    libxslt1-dev libmagickcore-dev libmagickwand-dev imagemagick libmysqlclient-dev \
    zlib1g-dev build-essential nfs-common libqtwebkit-dev libreadline-dev libffi-dev  \
    openjdk-7-jre libsqlite3-dev libssl-dev libffi-dev mysql-client vim supervisor
                      
COPY /etc/supervisor/conf.d/httpd.conf /etc/supervisor/conf.d/
# Add run script
COPY run.sh /
RUN chmod 755 /run.sh
COPY etc/apache2/apache2.conf /etc/apache2/
COPY etc/apache2/sites-available/mconf-web /etc/apache2/sites-available/
#COPY passenger.load /etc/apache2/mods-available/
RUN useradd -ms /bin/bash mconf
RUN adduser mconf www-data
RUN chown -R mconf:www-data /var/www/
RUN mkdir -p /opt/mconf/{scripts,backups}/ && \ 
    mkdir -p /opt/mconf/var/tmp && \
    touch /opt/mconf/var/tmp/firsttime
RUN echo "mconf ALL=(ALL) NOPASSWD:ALL"  >> /etc/sudoers    
#Mconf installation
USER mconf
RUN git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
# install ruby build
RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# install ruby
RUN bash -l -c "rbenv install 2.2.0"
RUN bash -l -c "rbenv rehash"
# set this version of ruby as the default and check it is correct
RUN bash -l -c "rbenv global 2.2.0"
RUN bash -l -c "rbenv version"
# install bundler
RUN bash -l -c "gem install bundler -v '1.7.2'"
RUN bash -l -c "rbenv rehash"
WORKDIR /var/www
#Download mconf latest
RUN bash -l -c "git clone git://github.com/mconf/mconf-web.git"
RUN chown -R mconf:www-data /var/www/mconf-web
WORKDIR /var/www/mconf-web/
#Install mconf
RUN bash -l -c "bundle install --path vendor/bundle --without=development test"
COPY database.yml /var/www/mconf-web/config/
COPY setup_conf.yml /var/www/mconf-web/config/
RUN bash -l -c "gem install passenger -v 4.0.59"
RUN bash -l -c "rbenv rehash"
RUN bash -l -c "passenger-install-apache2-module -a"
#Install passenger web server
RUN bash -l -c "passenger-install-apache2-module --snippet | sudo tee /etc/apache2/conf-available/mconf-passenger.conf"
USER root
RUN a2enconf mconf-passenger
RUN a2enmod rewrite && \ 
    a2enmod xsendfile
RUN mv /etc/apache2/sites-available/mconf-web /etc/apache2/sites-available/mconf-web.conf
RUN a2ensite mconf-web
USER mconf
EXPOSE 80
VOLUME ["/opt/mconf/var"]
CMD ["/run.sh"]