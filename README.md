# LDAPToolBox Self Service Password for docker

Docker container for [LTB Self Service Password](https://ltb-project.org/documentation/self-service-password). Dockerfile for project can be found at <https://github.com/lucamaro/docker-ltb-self-service-password>.

## Usage

Customize `config.inc.php.orig`, then run image customizing this command:

	docker run -d -p 8000:80 -v $PWD/config.inc.php.orig:/var/www/html/conf/config.inc.php \
			--name ltb lucamaro/ltb-self-service-password
			
## Recommended step: use TLS

In order to use TLS you must run the image with a volume containing certificate and key. Certificate name must be `ssl-cert.pem` and key name must be `ssl-cert.key`

	docker run -d -p 8443:443 \
			-e USE_SSL=1 \
			-v $PWD/certs:/etc/ssl/certs \
			-v $PWD/certs:/etc/ssl/private \
			--name dcim lucamaro/ltb-self-service-password

Optionally generate self signed certificates with the following commands:

	mkdir -p certs
	openssl req -x509 -newkey rsa:4096 -keyout certs/ssl-cert.key -out certs/ssl-cert.pem -days 365 -nodes
	
