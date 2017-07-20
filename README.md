# LDAPToolBox Self Service Password for docker

## Usage

Run image customizing this command:

	docker run -d -p 8000:80 \
			--name ltb lucamaro/ltb
			
Copy `config.inc.php`, customize it, then restart container:

	docker cp ltb:/var/www/html/conf/config.inc.php .
	vi config.inc.php
	docker cp config.inc.php ltb:/var/www/html/conf
	docker restart ltb