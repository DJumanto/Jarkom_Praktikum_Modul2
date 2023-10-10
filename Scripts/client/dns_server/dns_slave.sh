mkdir /etc/bind/delegasi

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

zone "baratayuda.abimanyu.f01.com"{
    type master;
    file "/etc/bind/delegasi/baratayuda.abimanyu.f01.com";
};
' > /etc/bind/named.conf.local

echo 'options{
        directory "/var/cache/bind";
        
        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6{ any; };
};' > /etc/bind/named.conf.options

echo '
;
; BIND data file for local loopback interface
;
$TTL  604800
@   IN      SOA     baratayuda.abimanyu.f01.com.  root.baratayuda.abimanyu.f01.com. (
                    2023100601      ; Serial
                        604800      ; Refresh
                        86400       ; Retry 
                        2419200     ; Expire
                        604800  )   ; Negative Cache TTL
;
@   IN      NS      baratayuda.abimanyu.f01.com.
@   IN      A       10.52.3.3       ;
www IN      CNAME   baratayuda.abimanyu.f01.com.
rjp IN      A       10.52.3.3       ;
www.rjp IN      CNAME   rjp.baratayuda.abimanyu.f01.com.
' > /etc/bind/delegasi/baratayuda.abimanyu.f01.com


service bind9 restart
service bind9 restart