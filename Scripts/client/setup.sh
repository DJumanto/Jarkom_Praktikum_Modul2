echo 'echo nameserver 192.168.122.1 > /etc/resolv.conf' > cl_starter1.sh
chmod +x cl_starter1.sh
echo './root/cl_starter1.sh' >> .bashrc
rm "$0"