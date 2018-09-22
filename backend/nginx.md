
#### HIGHLY PERFORMANT WEB SERVER

## Table of Contents

- [Table of Contents](#table-of-contents)
- [INSTALLATION](#installation)
  - [Install with a package manager](#install-with-a-package-manager)
    - [APT (Debian and Ubuntu)](#apt-debian-and-ubuntu)
    - [YUM (Fedora and CentOS)](#yum-fedora-and-centos)
  - [Install by building from source and adding modules](#install-by-building-from-source-and-adding-modules)
  - [Configure a system service for Nginx](#configure-a-system-service-for-nginx)
- [CONFIGURATION](#configuration)
  - [Contexts and Directives](#contexts-and-directives)
  - [Location Blocks](#location-blocks)
  - [Variables](#variables)
  - [Conditional Statements](#conditional-statements)
  - [Rewrites and Redirects](#rewrites-and-redirects)
  - [Try Files and Named Locations](#try-files-and-named-locations)
  - [Logging](#logging)
  - [Directive Types](#directive-types)
  - [Worker Processes](#worker-processes)
  - [Buffers and Timeouts](#buffers-and-timeouts)
  - [Adding Dynamic Modules](#adding-dynamic-modules)
- [PERFORMANCE](#performance)
  - [Headers and Expires](#headers-and-expires)
  - [Compressed Responses with gzip](#compressed-responses-with-gzip)
  
## INSTALLATION
### Install with a package manager
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
## CONFIGURATION

### Contexts and Directives

Two main Nginx configuration terms are **context** and **directive**;
- **Directives** are specific configurations options that get set in the configuration files and consist of __name__ and a __value__.
- **Context**, on the other hand, is a sections of a configuration where directives can be set for that given context. Essentially, __context__ is the same as scope. And like scope, contexts are also nested and inherit from their parents.

The main Nginx configuration file is /etc/nginx/__nginx.conf__
It may include configuration pieces from other .conf files by __include__ directive that takes a relative path to another .conf file as an argument. 

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
Location blocks define the server behavior on reqeusts to the specific URIs relative to the root directory.
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

### Conditional Statements
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

### Rewrites and Redirects

We can rewrite reqeusted URI and direct the client to another URI by using __rewrite__ or __return__ directives. In case of using __return__ with the 3** status codes, instead of string as a second parameters, it accepts an URI which the client should be redirected to. Syntax:
```css
return 3** <URI>
rewrite <regex pattern> <URI>
```
Example with __return__
```css
  server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    location /greet {
      return 307 /thumb.png;
    }
  }
```
Exaple with __rewrite__
```css
  server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    rewrite ^/user/\w+ /greet

    location /greet {
      return 200 "Hello User!";
    }
  }
```
Note that in case of using __return__, the URI of your reqeust will be changed to one you have been redirected to. If you use __rewrite__ directive, your URI will remain the same and you will get the content of redirection destination page.

We can also use regular expression to capture and use individual parts of the request URI with __$__ sign. In the exapmle below, we captured provided parameter to redirect the client to the specified location:
```css
  server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    rewrite ^/user/(\w+) /greet/$1

    location /greet {
      return 200 "Hello User!";
    }

    location = /greet/john {
       return 200 "Hello John!" 
    }
  }
```

Another useful feature is the __last__ flag to not allow the URI to be rewritten after the first rewrite. In the exapmle below, the first rewrite statement will trigger the redirection to ***/greet/john***, but will not be rewritten by the second statement, so ***"Hello John"*** will be returned instead of ***/thumb.png***.

```css
server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    rewrite ^/user/(\w+) /greet/$1 last;
    rewrite ^/greet/john /thumb.png;

    location /greet {

      return 200 "Hello User";
    }

    location = /greet/john {
      return 200 "Hello John";
    }
  }
```

### Try Files and Named Locations

__try_files__ directive can be used in __server__ context applying to all incoming requestst or inside individual __location__ contexts. It allows us to have Nginx checking a resource to respond with in any number of locations relative to the root directive. Syntax:
```css
try_files <path 1> <path 2> final;
```
In the exapmle below, Nginx serves __thumb.png__ file if one existst relative to the root directory and redirects to __/greet__ loction in case when file not found. Remmember that you can use other location (not files) only as the last argument to have Nginx re-evaluate the reqeust and make it caugth by location bloch.
```css
server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    try_files /thumb.png /greet;

    location /greet {
      return 200 "Hello User";
    }
  }
```
It is often when __try_files__ used with Nginx variables. For exapmple we can check for original request URI first before checking for other locations;
```css
server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    try_files $uri /thumb.png /greet;

    location /greet {
      return 200 "Hello User";
    }
  }
```
We can create default 404 location and set it as the last argument of __try_files__ to always show 404 page if any other resources haven't been found:
```css
  server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    try_files $uri /thumb.png /cat.jpeg /friendly_404;

    location /friendly_404 {
      return 404 "Sorry, this file could not be found.";
    }
  }
```
 Nginx allows us to name locations with _@_ prefix to, for example, use the name as the last argument of __try_files__. In the case of using named location, request doesn't get re-evaluated, it just calls directly.
 Example:
 ```css
  server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    try_files $uri /thumb.png /cat.jpeg @friendly_404;

    location @friendly_404 {
      return 404 "Sorry, this file could not be found.";
    }
  }
 ```

### Logging

Nginx provides us two log types: __Error Log__ for anything that failed or didn't happen as expected, and __Access Log__ for logging all requests to the server. Logging is enabled by default and writes logs to two corresponding files: __/var/log/nginx/error.log__ and __/var/log/nginx/access.log__
Leaving default logging configuration will be enough for most cases, but sometimes we need to create custom log files or disable logging for specific context. We can do it with __access_log__ and __error_log__ directives.

Custom logging for specific context:
```css
server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    location /secure {
      access_log /var/log/nginx/secure.access.log
      return 200 "Welcome to secure area.";
    }
  }
``` 
 Disable logging for a given context:

 ```css
server {

    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    location /secure {
      access_log off
      return 200 "Welcome to secure area.";
    }
  }
``` 
For more advances logging configuration, see this article: https://docs.nginx.com/nginx/admin-guide/monitoring/logging

### Directive Types
__1. Array Directive__
Can be specified multiple times without overriding a previous setting
Gets inherited by all child contexts
Child context can override inheritance by re-declaring directive
```css
access_log /var/log/nginx/access.log;
access_log /var/log/nginx/custom.log.gz custom_format;
```
__2. Standard Directive__
   Can only be declared once. A second declaration overrides the first
  Gets inherited by all child contexts
  Child context can override inheritance by re-declaring directive
  ```css
  root /sites/site2;
  ```

__3. Action Directive__
  Invokes an action such as a rewrite or redirect
  Inheritance does not apply as the request is either stopped (redirect/response) or re-evaluated (rewrite). 
  ```css
  return 403 "You do not have permission to view this.";
  ```
### Worker Processes
Nginx always has one Master process and one or more Worker processes. Master process is the actual Nginx service (or software instance) which we started. That master process than spawns worker processes which actually deal with client requests and corresponding responses.
The default number or worker processes is 1. To change this number, __worker_processes__ directive is used. Declare it in the main context.

```css
worker_processes 2;

events{}

http {
  ...
}
```
NOTE: increasing the number of worker processes does not guarantee the increase of performance. By its asynchronous nature, Nginx will handle requests as fast as the hardware is capable of. Single Nginx worker process can run properly only on a single CPU core. If you try to run, for example, two worker processes on a single core, think of the result as each of the processes runs only on 50% of its capabilities. So there's no reason to spawn more processes than number of CPU cores of the actual machine. To check how many cores your processes has, run:
```
nproc
```
or
```
lscpu
```
But Nginx gives us a very simple way of automating this by setting __worker_processes__ direcetive argument to *__auto__*:
```css
worker_processes auto;
```
Another related directive is __worker_connections__. It control the number of connections the worker process can accept and declares in the __events__ context. It's better to set its value to the number of your machine's limit of number of files that can be opened at once (for each CPU core). To check this number, run:
```css
ulimit -n
```
Than set the value
```css
events{

  worker_connections 1024

}
```
Now you can find the maximum number of cuncurrent requests our server should be able to accept: __worker_processes__ x __worker_connections__ = max connections.

### Buffers and Timeouts
To optimize Nginx processes, we can configure buffer sizes and timeouts. But we should do this only on purpose because default settings are already optimized for the general range of tasks.
- __Buffer__ is a layer of protection that allows us to use machine's memory effectively.
  Nginx buffering directives are declared in the __http__ context and are self-explainatory. 
  Example:
  ```css
  // Buffer size for POST submissions
  client_body_buffer_size 10K;
  client_max_body_size 8m;

  // Buffer size for Headers
  client_header_buffer_size 1k;
  ```
  For the amount of memory that will be allocated for the buffer, Nginx supports following abbreviatins:
  - 100 (plain number) // bytes
  - 10K (or 10k) // kilobytes
  - 10M (or 10m) // megebytes

  We can configure Nginx to not use the buffer at all for specific cases (it will read data from the disk and write it directly to the response). 
  ```css
  // Skips buffering for static files
  sendfile on;

  // Optimise sendfile packets size
  tcp_nopush on;
  ```

- __Timeouts__ set a cut-off time to a given event (request). It can, for example, prevent a client to send and endless stream of data that will cause the breaking the server. 
  ```css
  // Max time to receive client headers/body
  client_body_timeout 12;
  client_header_timeout 12;

  // Max time to keep a connection open for
  keepalive_timeout 15;

  // Max time for the client accept/receive a response
  send_timeout 10;
  ```
  Timeouts, by default, are set in *milliseconds*. But we can specify it in range from seconds even up to years:
   ```css
   client_body_timeout 12; // millisecnods
   client_body_timeout 12s; // seconds
   client_body_timeout 12m; // minutes
   client_body_timeout 12h; // hours
   client_body_timeout 12d; // days ...
   ```
### Adding Dynamic Modules
In order to add new modules to Nginx we have to re-build it from source, so we'll need the source code (see the __INSTALLATION__ section).

**Steps:**
__1.__ Check Nginx existing configuration the current install was built with.
  ```css
  nginx -V
  ```
__2.__ Copy the configuration.
   ```css
   --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module
   ```
__3.__ Add our new modules to this configuraton.
  - Check the dynamic modules available with downloaded source code
  
    ```css
    ./configure --help | grep dynamic
    ```
  - Choose module to install from the list. For example, we have chosen __http_image_filter_module__. 
  Now we need just copy previous __./configure__ command and add our module to it to get new module compiled into Nginx along with others. Don't forget to add __--with__ prefix and __=dynamic__ postfix to the modules name, it should look like this: __--with_http_image_filter_module=dynamic__.
  We also have to specify the modules path to make Nginx find them much easier:
  __--modules_path=/etc/nginx/modules__.
  Final command shold look like this:   
    ```css
    ./configure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module
    --with_http_image_filter_module=dynamic --modules_path=/etc/nginx/modules
    ```
__4.__ Run the command above and then compile and install Nginx.
```css
make && make install
```   
__5.__ Reload Nginx and check its status
   ``` css
   systemctl reload nginx && systemctl status nginx
   ```
__6.__ Now we can use installed module in the confifuration by adding it with __load_module__ directive.
  ```css
load_module modules/ngx_http_image_filter_module.so;

events {}

http {

  include mime.types;

  server {

    listen 80;
    server_name *.mydomain.con;

    root /sites/demo;

    location = /thumb.png {
        image_filter rotate 180;
      }
    }
  }
   ```

## PERFORMANCE

### Headers and Expires
Nginx allows us to set headers with __add_header__ directive followed by header name and value.

An __Expires__ http header informs the client how long it can cache its response for. It used for the data that doesn't change often, so the client can skip requesting it form the server every time and use its own cache.
We can set up an __Expires__ header manually with standart __add_header__ directive, but Nginx provides a simple and convenient directive __expires__. It allows us to use Nginx's duration (in minutes, hours, months, etc.) instead of the full date value that required for that header by HTTP protocol spec.

Following example shows how to set corresponding headers and an cache expiration time for 1 month for all static files in particular path.
```css
location ~* \.(css|js|jpg|png)$ {
    access_log off;
    add_header Cache-Control public;
    add_header Pragma public;
    add_header Vary Accept-Encoding;
    expires 1M;
  }
```

### Compressed Responses with gzip
We can compress server's response data to decrease its size and delivery time.

First we need to enable a __gzip__ compression:
```css
http {

  gzip on;

  server {
    ...
  }
}
```
The next directive is __gzip_comp_lever__. It allows us to set the amount of compression used. A lower number is resulting a larger files but requiring less server resources, and  a higher number is resluting a smaller files but more server resource is required. Note that at levels over 5 the reduction in file size becomes very minor,so typically 3 or 4 is a good option. 

Then we need to specify the file types to apply a compression to. It can be done with __gzip_types__ directive. 
```css
http {

  gzip on;
  gzip_comp_level 3;

  gzip_types text/css;
  gzip_types text/javascript;

  server {
    
    listen 80;
    server_name *.mydomain.com;

    root /sites/demo;

    location ~* \.(css|js|jpg|png)$ {
      access_log off;
      add_header Cache-Control public;
      add_header Pragma public;
      add_header Vary Accept-Encoding;
      expires 1M;
    }
  }
}
```

Important to know that the client should accept conpressed responses by specifing allowed compression types in __"Accept-Encoding"__ request header.

For more on __gzip__ module, see the docs: http://nginx.org/en/docs/http/ngx_http_gzip_module.html





