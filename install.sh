#!/bin/sh



cd /usr/ports/lang/php5-extensions/ && make config install clean
cd /usr/local/etc && cp php.ini-development php.ini


cd /usr/ports/www/nginx/ && make install clean

echo "JK SCRIPT ADD" >> /usr/local/etc/nginx/nginx.conf
echo "" >> /usr/local/etc/nginx/nginx.conf
echo "location / {" >> /usr/local/etc/nginx/nginx.conf
echo "    root    /domain/jk.hk;" >> /usr/local/etc/nginx/nginx.conf
echo "    index    index.html index.htm index.php;" >> /usr/local/etc/nginx/nginx.conf
echo "}" >> /usr/local/etc/nginx/nginx.conf
echo "" >> /usr/local/etc/nginx/nginx.conf
echo "location ~ \.php$ {" >> /usr/local/etc/nginx/nginx.conf
echo "    fastcgi_pass    127.0.0.1:9000;" >> /usr/local/etc/nginx/nginx.conf
echo "    fastcgi_index   index.php;" >> /usr/local/etc/nginx/nginx.conf
echo "    fastcgi_param     SCRIPT_FILENAME    /scripts$fastcgi_script.name;" >> /usr/local/etc/nginx/nginx.conf
echo "    include      fastcgi_params;" >> /usr/local/etc/nginx/nginx.conf
echo "}" >> /usr/local/etc/nginx/nginx.conf


echo 'mysql_enable="YES"' >> /etc/rc.conf
echo 'nginx_enable="YES"' >> /etc/rc.conf
echo 'php_fpm_enable="YES"' >> /etc/rc.conf


