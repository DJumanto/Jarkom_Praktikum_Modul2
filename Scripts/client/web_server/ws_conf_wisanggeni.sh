echo '
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>wisanggeni</title>
</head>
<body>
    Hello from wisanggeni
</body>
</html>
' > /var/www/html/index.html

echo '
server {
    listen 8003;
    root /var/www/html/;
    index index.html index.htm;  # Remove index.php from here
    server_name _;

    location / {
        try_files $uri $uri/ =404;  # Adjust the try_files directive as needed
    }

    error_log /var/log/nginx/wisanggeni_error.log;
    access_log /var/log/nginx/wisanggeni_access.log;
}
 ' > /etc/nginx/sites-available/wisanggeni.f01.com

 ln -s /etc/nginx/sites-available/wisanggeni.f01.com /etc/nginx/sites-enabled
 
 service nginx restart