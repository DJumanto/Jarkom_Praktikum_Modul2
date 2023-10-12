rm /var/www/html/*
mv abimanyu.yyy.com/* /var/www/html/
rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*
rm /etc/apache2/sites-enabled/*
rm /etc/apache2/sites-available/*
mkdir /var/www/parikesit.abimanyu.f01/
cp -r parikesit.abimanyu.yyy.com/* /var/www/parikesit.abimanyu.f01/
mkdir /var/www/parikesit.abimanyu.f01/secret/
mkdir /var/www/rjp.baratayuda.abimanyu.f01/
cp -r rjp.baratayuda.abimanyu.yyy.com/* /var/www/rjp.baratayuda.abimanyu.f01/

echo '
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Flag</title>
</head>
<body>
    jarkom2023{n3v3r_sh4r3_y0ur_s3cr3tssss}
</body>
</html>
' > /var/www/parikesit.abimanyu.f01/secret/flag.html

service php7.2-fpm start

a2enmod rewrite

echo '
server {
    listen 8002;
    root /var/www/html/;
    index index.php index.html index.htm;
    server_name _;

    location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

    error_log /var/log/nginx/abimanyu_error.log;
    access_log /var/log/nginx/abimanyu_access.log;
}
 ' > /etc/nginx/sites-available/abimanyu.f01.com


mkdir /var/www/abimanyu.f01
cp /var/www/html/* /var/www/abimanyu.f01/

echo '
<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.f01.com
    ServerName abimanyu.f01.com
    ServerAlias www.abimanyu.f01.com
    DocumentRoot /var/www/abimanyu.f01/
    <Directory /var/www/abimanyu.f01/>
        Options +Indexes
        AllowOverride All
    </Directory>
    DirectoryIndex index.php index.html
    ErrorLog ${APACHE_LOG_DIR}/abimanyu_error.log
    CustomLog ${APACHE_LOG_DIR}/abimanyu_access.log combined
</VirtualHost>
' > etc/apache2/sites-available/abimanyu.f01.conf

 echo '
<VirtualHost *:80>
    ServerAdmin webmaster@parikesit.abimanyu.f01.com
    ServerName parikesit.abimanyu.f01.com
    ServerAlias www.parikesit.abimanyu.f01.com
    DocumentRoot /var/www/parikesit.abimanyu.f01
    Alias "/js" "/var/www/parikesit.abimanyu.f01/public/js"
    <Directory /var/www/parikesit.abimanyu.f01>
        Options +Indexes +FollowSymLinks -Multiviews
        AllowOverride All 
    </Directory>
    <Directory /var/www/parikesit.abimanyu.f01/public/>
        Options +Indexes
        AllowOverride All
    </Directory>
    <Directory /var/www/parikesit.abimanyu.f01/secret/>
        Options -Indexes
        AllowOverride Limit
        Require all denied
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/parikesit_error.log
    CustomLog ${APACHE_LOG_DIR}/parikesit_access.log combined
</VirtualHost>
' > etc/apache2/sites-available/parikesit.abimanyu.f01.conf


echo '
server {
    listen 14000;
    server_name www.rjp.baratayuda.abimanyu.f01.com;

    root /var/www/rjp.baratayuda.abimanyu.f01;
    #index index.php index.html index.htm;

    location / {
        autoindex on;
        autoindex_exact_size on;
        auth_basic "Area Tertutup";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
    error_log /var/log/nginx/rjp_error.log;
    access_log /var/log/nginx/rjp_access.log;
}

server {
    listen 14400;
    server_name www.rjp.baratayuda.abimanyu.f01.com;

    root /var/www/rjp.baratayuda.abimanyu.f01/;
    #index index.php index.html index.htm;

    location / {
        autoindex on;
        autoindex_exact_size on;
        auth_basic "Area tertutup";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }

    error_log /var/log/nginx/rjp_error.log;
    access_log /var/log/nginx/rjp_access.log;
}

' > etc/nginx/sites-available/rjp.baratayuda.abimanyu.f01.com

ln -s /etc/nginx/sites-available/abimanyu.f01.com /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/rjp.baratayuda.abimanyu.f01.com /etc/nginx/sites-enabled

chown -R www-data:www-data /var/www/rjp.baratayuda.abimanyu.f01/
htpasswd -b /etc/nginx/.htpasswd Wayang baratayudaf01
 
service nginx restart

echo '
RewriteEngine On
RewriteBase /

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^index\.php/(.*)$ /$1 [L,R=301]
' > /var/www/abimanyu.f01/.htaccess

echo '
Deny from all
' > /var/www/parikesit.abimanyu.f01/secret/.htaccess

echo '
RewriteEngine On
RewriteCond %{REQUEST_URI} !^/public/images/abimanyu.png
RewriteCond %{REQUEST_URI} abimanyu
RewriteRule \.(jpg|jpeg|png)$ /public/images/abimanyu.png [L]

ErrorDocument 403 /error/403.html
ErrorDocument 404 /error/404.html
' > /var/www/parikesit.abimanyu.f01/.htaccess

echo '
server {
    listen 80 default_server;
    server_name _;

    return 301 http://www.abimanyu.f01.com$request_uri;
}
' > /var/www/default_abimanyu

echo nameserver 10.52.1.4 > /etc/resolv.conf
echo nameserver 10.52.1.5 >> /etc/resolv.conf
echo nameserver 192.168.122.1 >> /etc/resolv.conf

a2ensite abimanyu.f01.conf
a2ensite parikesit.abimanyu.f01.conf
service apache2 restart
service php7.2-fpm restart
