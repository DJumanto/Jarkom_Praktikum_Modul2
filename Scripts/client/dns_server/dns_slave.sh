echo 'zone "abimanyu.f01.com" {
    type slave;
    masters { 10.52.1.4; };
    file "/var/lib/bind/abimanyu.f01.com";
};

zone "arjuna.f01.com" {
    type slave;
    masters { 10.52.1.4; };
    file "/var/lib/bind/arjuna.f01.com";
};
' > /etc/bind/named.conf.local

service bind9 restart
service bind9 restart