
#### HIGHLY PERFORMANT WEB SERVER

- ## INSTALLATION

###Install with a package manager
Quick and easy but doesn't allow to install any extra modules

#### APT (Debian and Ubuntu)

```css
apt-get update
apt-get install nginx
```
After installation with **apt-get**, Nginx starts running automatically.

Check the installation and started process
```css
ps aux | grep nginx
```
Check configuraton files now stored in following directory
```css
ls -l /etc/nginx
```

#### YUM (Fedora and CentOS)
```css
yum install epel-release
yum install nginx
```
After installation with **yum**, Nginx doesn't run automatically. You need to start it as a service with following command.
```css
service nginx start
```

### Install by building from source and adding modules

Go to http://nginx.org/en/download.html, find Mainline version, copy the link and download the archive
```css
wget http://nginx.org/download/nginx-1.15.3.tar.gz
```
Extract files from the archive and chage into extracted directory
```css
tar -zxvf nginx-1.15.3.tar.gz 
cd nginx-1.15.3
```
In order to compile our source code we need to install a compiler
**apt**
```css
apt-get install build-essential
```
**yum**
```css
yum groupinstall "Development Tools"
```
Install additinal required dependecies
**apt**
```css
apt-get install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev 
```
**yum**
```css
yum install pcre pcre-devel zlib zlib-devel openssl openssl-devel
```
Configure the source code for the build
```css
./cofigure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module
```
See complete list of options for install modules here: http://nginx.org/en/docs/configure.html

Compile configured source code and than install the compiled source
```css
make && make install
```
Test installation by checking Nginx version
```nginx
nginx -V
```
Now you can start Nginx by simply running
```nginx
nginx
```

### Configure a system service for Nginx
This will allow us to start, stop, restart, reload configuration and start Nginx on boot much simplier

Create and save following file as /lib/systemd/system/nginx.service
```css
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
```css
systemctl start nginx //start nginx
systemctl status nginx //check nginx status
systemctl stop nginx //stop nginx
systemctl enable nginx //make nginx always start on boot
```

- ## CONFIGURATION

Two main configuration terms are **context** and **directive**;
- **Directives** are specific configurations options that get set in the configuration files and consist of __name__ and a __value__.
- **Context**, on the other hand, is a sections of a configuration where directives can be set for that given context. Essentially __context__ is the same as scope. And like scope, context are also nestted and inherit from their parents.

The main configuration file is /etc/nginx/__nginx.conf__
It may include configuration pieces from other .conf files by __include__ \<file relative path> directive. 

Basic example
```css

events {}

http {

  include mime.types;

  server {

    listen 80; 
    server_name *.mydomain.com;

    root /sites/demo;
  }
}

```

After altering the .conf file, you need to reload the server to changes take effect. To do it without downtime, use:
```css
systemctl reload nginx
```

If your configuration is not workin as expected, verify the syntax by running:
```css
nginx -t
```

### Location Blocks
Location blocks define the server behavior on reqeusts to the specific URIs (or routes) relative to the root directory.
```css
location = <URI> {
    /...handle response
}
```

There are four types of URI match patterns
__1. Exact match__
   ```css
   =
   ```
   Example
   ```css
   location = /greet {
      return 200 'Hello from NGINX "/greet" location.';
    }
   ```
__2. Preferential prefix match__
   ```css
   ^~
   ```
   Example
   ```css
   location ^~ /Greet2 {
      return 200 'Hello from NGINX "/greet" location.';
    }
   ```
__3. Case sensitive REGEX match__
   ```css
   ~
   ```      
   Example
   ```css
    location ~ /greet[0-9] {
      return 200 'Hello from NGINX "/greet" location - REGEX MATCH.';
    }
   ```
__4. Case insensitive REGEX match__ (same priority as case sensitive REGEX match)
   ```css
    *~
   ```
   Example
   ```css
   location ~* /greet[0-9] {
      return 200 'Hello from NGINX "/greet" location - REGEX MATCH INSENSITIVE.';
    }
   ```
__5. Prerfix match__ 
```css
// no modifier, just URI
```
Example
```css
location /greet {
    return 200 'Hello from NGINX "/greet" location - PREFIX MATCH.';
}
```

__nginx.conf__
```css

http {

  include mime.types;

  server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    // Preferential Prefix match
    location ^~ /Greet2 {
      return 200 'Hello from NGINX "/greet" location.';
    }

    // REGEX match - case insensitive
    location ~* /greet[0-9] {
      return 200 'Hello from NGINX "/greet" location - REGEX MATCH INSENSITIVE.';
    }
  }
}
```
### Variables

Nginx provodes a set of useful native variables. They all prefixed with a __$__ sign.
```css
$host
$uri
$args
```

Usage example: the response of /inspect route will be a requested host, uri and arguments provided in the request query string
```css
location /inspect {
    return 200 "$host\n $uri\n $args";
}
```
If our query string has two parameters __fname__ and __lname__, we can get its values individually:
```css
location /inspect {
    return 200 "First Name: $arg_fname\n Last Name: $arg_lname";
}
```
See the full list of Nginx native variables here: http://nginx.org/en/docs/varindex.html

We can create our own variables with a special __set__ directive followed by variable name and its value (can be a string, an integer or boolean.
```css
set $admin "Yes";
```
After the declaration we can use our new variable in the context it has been declared in and all child contexts.

### Conditional Statemets
Nginx config syntax supports basic conditional statements with __if__ directive.

```css
server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    set $mon 'No';

    if ( $date_local = 'Monday' ) {
      set $mon 'Yes';
    }

    location /is_monday {

      return 200 $mon;
    }
  }
```
We can alse use regular expressions in conditional statements with __~__ operator:
```css
if ( $date_local ~ 'Saturday|Sunday' ) {
      set $weekend 'Yes';
    }
```
Note that using conditional statemets inside the location blocks is higly discouraged, it can cause unexpected behavior. See the article: https://www.nginx.com/resources/wiki/start/topics/depth/ifisevil



 