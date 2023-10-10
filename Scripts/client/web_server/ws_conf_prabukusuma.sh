service php7.2-fpm restart

echo '
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>prabukusuma</title>
</head>
<body>
    Hello from prabukusuma
</body>
</html>
' > /var/www/html/index.html

echo '
server {
    listen 8001;
    root /var/www/html/;
    index index.html index.htm;
    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    error_log /var/log/nginx/prabukusuma_error.log;
    access_log /var/log/nginx/prabukusuma_access.log;
}
 ' > /etc/nginx/sites-available/prabukusuma.f01.com

 ln -s /etc/nginx/sites-available/prabukusuma.f01.com /etc/nginx/sites-enabled
 
 service nginx restart