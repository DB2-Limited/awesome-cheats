
#### HIGHLY PERFORMANT WEB SERVER

- ## INSTALLATION

###Install with a package manager
Quick and easy but doesn't allow to install any extra modules

#### APT (Debian and Ubuntu)

```
apt-get update
apt-get install nginx
```
After installation with **apt-get**, Nginx starts running automatically.

Check the installation and started process
```
ps aux | grep nginx
```
Check configuraton files now stored in following directory
```
ls -l /etc/nginx
```

#### YUM (Fedora and CentOS)
```
yum install epel-release
yum install nginx
```
After installation with **yum**, Nginx doesn't run automatically. You need to start it as a service with following command.
```
service nginx start
```

### Install by building from source and adding modules

Go to http://nginx.org/en/download.html, find Mainline version, copy the link and download the archive
```
wget http://nginx.org/download/nginx-1.15.3.tar.gz
```
Extract files from the archive and chage into extracted directory
```
tar -zxvf nginx-1.15.3.tar.gz 
cd nginx-1.15.3
```
In order to compile our source code we need to install a compiler
**apt**
```
apt-get install build-essential
```
**yum**
```
yum groupinstall "Development Tools"
```
Install additinal required dependecies
**apt**
```
apt-get install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev 
```
**yum**
```
yum install pcre pcre-devel zlib zlib-devel openssl openssl-devel
```
Configure the source code for the build
```
./cofigure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module
```
See complete list of options for install modules here: http://nginx.org/en/docs/configure.html

Compile configures source code
```
make
```
Than install the compiled source
```
make install
```
Test installation by checking Nginx version
```
nginx -V
```
Now you can start Nginx by simply running
```
nginx
```

### Configure a system service for Nginx
This will allow us to start, stop, restart, reload configuration and start Nginx on boot much simplier

Create and save following file as /lib/systemd/system/nginx.service
```
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/bin/nginx -t
ExecStart=/usr/bin/nginx
ExecReload=/usr/bin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

Now you can user **systemctl** to control Nginx
```
systemctl start nginx //start nginx
systemctl status nginx //check nginx status
systemctl stop nginx //stop nginx
systemctl enable nginx //make nginx always start on boot
```