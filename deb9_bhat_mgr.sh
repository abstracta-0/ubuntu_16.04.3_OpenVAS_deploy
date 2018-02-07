!#/bin/bash

# insure that the system is up to date
apt update && apt upgrade -y && apt dist-upgrade -y

apt install -y build-essential cmake bison flex libpcap-dev pkg-config libglib2.0-dev libgpgme11-dev uuid-dev sqlfairy xmltoman doxygen libssh-dev libksba-dev libldap2-dev libsqlite3-dev libmicrohttpd-dev libxml2-dev libxslt1-dev xsltproc clang rsync rpm nsis alien sqlite3 libhiredis-dev libgcrypt11-dev libgnutls28-dev redis-server texlive-latex-base texlive-latex-recommended linux-headers-$(uname -r) python python-pip mingw-w64 heimdal-multidev libpopt-dev libglib2.0-dev gnutls-bin certbot nmap ufw

# cleanly download and compile packages/libraries to /etc/OpenVAS
mkdir /etc/OpenVAS
path="/etc/OpenVAS"
cd $(echo $path | tr -d '\r')

wget -nc chttp://wald.intevation.org/frs/download.php/2420/openvas-libraries-9.0.1.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2423/openvas-scanner-5.1.1.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2448/openvas-manager-7.0.2.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2429/greenbone-security-assistant-7.0.2.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2397/openvas-cli-1.4.5.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2377/openvas-smb-1.0.2.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2401/ospd-1.2.0.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2405/ospd-debsecan-1.2b1.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2218/ospd-nmap-1.0b1.tar.gz

for i in $(ls *.tar.gz); do tar zxvf $i; done
