echo 'echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
echo nameserver 10.52.1.4 > /etc/resolv.conf
echo nameserver 10.52.1.5 >> /etc/resolv.conf' > cl_starter.sh
chmod +x cl_starter.sh
echo './root/cl_starter.sh' >> .bashrc
rm "$0"