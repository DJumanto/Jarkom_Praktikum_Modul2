mkdir /etc/bind/jarkom

echo 'zone "arjuna.f01.com" {
	type master;
    also-notify { 10.52.1.5; };
    allow-transfer { 10.52.1.5; };
	file "/etc/bind/jarkom/arjuna.f01.com";
};

zone "abimanyu.f01.com" {
	type master;
    also-notify { 10.52.1.5; };
	file "/etc/bind/jarkom/abimanyu.f01.com";
    allow-transfer { 10.52.1.5; };
};

zone "1.52.10.in-addr.arpa" {
	type master;
	file "/etc/bind/jarkom/1.52.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local


echo '
;
; BIND data file for local loopback interface
;
$TTL  604800
@   IN      SOA     arjuna.f01.com.  root.arjuna.f01.com. (
                    2023100601      ; Serial
                        604800      ; Refresh
                        86400       ; Retry 
                        2419200     ; Expire
                        604800  )   ; Negative Cache TTL
;
@   IN      NS      arjuna.f01.com.
@   IN      A       10.52.2.2       ;
www IN      CNAME   arjuna.f01.com.
@   IN      AAAA    ::1
' > /etc/bind/jarkom/arjuna.f01.com


echo '
;
; BIND data file for local loopback interface
;
$TTL  604800
@   IN      SOA     abimanyu.f01.com.  root.abimanyu.f01.com. (
                    2023100601      ; Serial
                        604800      ; Refresh
                        86400       ; Retry 
                        2419200     ; Expire
                        604800  )   ; Negative Cache TTL
;
@   IN      NS      abimanyu.f01.com.
@   IN      A       10.52.3.3       ;
www IN      CNAME   abimanyu.f01.com.
www.parikesit IN      CNAME   parikesit.abimanyu.f01.com.
parikesit   IN  A   10.52.3.3
ns1 IN      A       10.52.1.5
baratayuda  NS      ns1
@   IN      AAAA    ::1
' > /etc/bind/jarkom/abimanyu.f01.com

echo '
;
; BIND data file for local loopback interface
;
$TTL  604800
@   IN      SOA     abimanyu.f01.com.  root.abimanyu.f01.com. (
                    2023100603      ; Serial
                        604800      ; Refresh
                        86400       ; Retry 
                        2419200     ; Expire
                        604800  )   ; Negative Cache TTL
;
1.52.10.in-addr.arpa.    IN  NS  abimanyu.f01.com.
4   IN  PTR    abimanyu.f01.com.
' > /etc/bind/jarkom/1.52.10.in-addr.arpa


echo 'options{
        directory "/var/cache/bind";
        
        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6{ any; };
};' > /etc/bind/named.conf.options


service bind9 restart
service bind9 restart