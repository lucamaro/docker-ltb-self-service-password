#! /bin/sh


if [ ! -f /.configured ] ; then
	if [ "$USE_SSL" = "1" ] ; then
		a2enmod ssl
		a2ensite default-ssl
		sed -i "s/ssl-cert-snakeoil/ssl-cert/" /etc/apache2/sites-available/default-ssl.conf 
	fi
	touch /.configured
fi


exec docker-php-entrypoint "$@"
