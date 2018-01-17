FROM debian:8.10
MAINTAINER Nicolas FATREZ <developer@unid-consulting.fr>

ENV APP_ENV development
ENV WWW /var/www/html
ENV PORT 80
ENV VHOST localhost.dev

RUN apt-get update && apt-get -y upgrade;
RUN apt-get install apt-transport-https lsb-release ca-certificates wget -y;
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get -y install nano;
RUN apt-get -y install apache2;
RUN apt-get -y install php7.2 libapache2-mod-php7.2;
RUN apt-get -y install php7.2-mysqlnd php7.2-curl php7.2-gd php-pear php7.2-imagick php7.2-imap php7.2-xmlrpc php7.2-xsl php7.2-intl;
RUN cd /tmp; wget https://getcomposer.org/composer.phar; chmod +x /tmp/composer.phar; mv /tmp/composer.phar /usr/local/bin/composer;
RUN a2enmod rewrite;

VOLUME /var/www/html
VOLUME /etc/apache2/sites-enabled

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 
COPY conf/template.conf /tmp
COPY run.sh /tmp

CMD /bin/sh /tmp/run.sh
