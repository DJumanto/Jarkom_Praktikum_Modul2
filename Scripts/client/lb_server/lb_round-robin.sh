rm /etc/nginx/sites-available/default
echo '
upstream worker {
        server 10.52.3.2:8001;
        server 10.52.3.3:8002;
        server 10.52.3.4:8003;
}

server {
    listen 80;
    
    server_name arjuna.f01.com www.arjuna.f01.com;

    location / {
        proxy_pass http://worker;
    }
}' > /etc/nginx/sites-available/arjuna.f01.com

ln -s /etc/nginx/sites-available/arjuna.f01.com /etc/nginx/sites-enabled

service nginx restart