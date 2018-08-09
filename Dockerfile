FROM php:7.2.8-apache
MAINTAINER Luca Maragnani "luca.maragnani@gmail.com"

# Installation of nesesary package/software for this containers...
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \ 
	&& apt-get install -y -q --no-install-recommends \
		libldap2-dev \
		libmcrypt-dev \
		wget \
	# See https://serverfault.com/questions/633394/php-configure-not-finding-ldap-header-libraries
	&& ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
	&& ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
	&& docker-php-ext-install ldap mbstring 

RUN  pecl install mcrypt-1.0.1 \
	&& docker-php-ext-enable mcrypt 
RUN 	cd /var/www && rm -rf html \
	&& wget -q -O - http://ltb-project.org/archives/ltb-project-self-service-password-1.3.tar.gz | tar xzf - \
	&& mv ltb-project-self-service-password-1.3 html 
	
EXPOSE 80

# init script as entrypoint for initial configuration
COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh", "-DFOREGROUND"]
	
 
	
