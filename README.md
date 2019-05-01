# webdock

```sh
cp env-example .env
docker-compose up -d --no-deps php-fpm7.2 php-fpm5.6 mysql nginx 
# docker-compose build --force-rm php-fpm5.6
```

## Xdebug

PHPSTORM 配置 `.env` 中 `PHP_IDE_CONFIG` 参数serverName同名的server，并设置path映射

`.env` 配置 `DOCKER_HOST_IP`

`xdebug.ini` 修改

```ini
xdebug.remote_host=dockerhost # 开启
xdebug.remote_connect_back=0 # 关闭
```

## MongoDB

### Window 下 volumes 报错

Window下使用时，使用 volumes 映射宿主机目录到 `/data/db`，会报如下`Operation not permitted`错误：

```sh
2018-10-22T05:54:58.004+0000 I CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] MongoDB starting : pid=1 port=27017 dbpath=/data/db 64-bit host=1dd1bb0931f9
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] db version v4.0.3
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] git version: 7ea530946fa7880364d88c8d8b6026bbc9ffa48c
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] OpenSSL version: OpenSSL 1.0.2g  1 Mar 2016
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] allocator: tcmalloc
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] modules: none
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] build environment:
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten]     distmod: ubuntu1604
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten]     distarch: x86_64
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten]     target_arch: x86_64
2018-10-22T05:54:58.008+0000 I CONTROL  [initandlisten] options: { net: { bindIpAll: true } }
2018-10-22T05:54:58.013+0000 I STORAGE  [initandlisten] wiredtiger_open config: create,cache_size=478M,session_max=20000,eviction=(threads_min=4,threads_max=4),config_base=false,statistics=(fast),log=(enabled=true,archive=true,path=journal,compressor=snappy),file_manager=(close_idle_time=100000),statistics_log=(wait=0),verbose=(recovery_progress),
2018-10-22T05:54:58.607+0000 E STORAGE  [initandlisten] WiredTiger error (1) [1540187698:607451][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: Operation not permitted Raw: [1540187698:607451][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: Operation not permitted
2018-10-22T05:54:58.639+0000 E STORAGE  [initandlisten] WiredTiger error (17) [1540187698:639154][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: File exists Raw: [1540187698:639154][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: File exists
2018-10-22T05:54:58.641+0000 I STORAGE  [initandlisten] WiredTiger message unexpected file WiredTiger.wt found, renamed to WiredTiger.wt.1
2018-10-22T05:54:58.641+0000 E STORAGE  [initandlisten] WiredTiger error (1) [1540187698:641873][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: Operation not permitted Raw: [1540187698:641873][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: Operation not permitted
2018-10-22T05:54:58.672+0000 E STORAGE  [initandlisten] WiredTiger error (17) [1540187698:672400][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: File exists Raw: [1540187698:672400][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: File exists
2018-10-22T05:54:58.674+0000 I STORAGE  [initandlisten] WiredTiger message unexpected file WiredTiger.wt found, renamed to WiredTiger.wt.2
2018-10-22T05:54:58.674+0000 E STORAGE  [initandlisten] WiredTiger error (1) [1540187698:674965][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: Operation not permitted Raw: [1540187698:674965][1:0x7f219cf7fa00], connection: __posix_open_file, 715: /data/db/WiredTiger.wt: handle-open: open: Operation not permitted
2018-10-22T05:54:58.676+0000 W STORAGE  [initandlisten] Failed to start up WiredTiger under any compatibility version.
2018-10-22T05:54:58.676+0000 F STORAGE  [initandlisten] Reason: 1: Operation not permitted
2018-10-22T05:54:58.676+0000 F -        [initandlisten] Fatal Assertion 28595 at src/mongo/db/storage/wiredtiger/wiredtiger_kv_engine.cpp 645
2018-10-22T05:54:58.676+0000 F -        [initandlisten] 
2018-10-22T05:54:58.676245100Z 
***aborting after fassert() failure
```

#### 原因见 [mongo docker image documentation](https://hub.docker.com/_/mongo/)：

> **WARNING (Windows & OS X)**: The default Docker setup on Windows and OS X uses a VirtualBox VM to host the Docker daemon. Unfortunately, the mechanism VirtualBox uses to share folders between the host system and the Docker container is not compatible with the memory mapped files used by MongoDB (see [vbox bug](https://www.virtualbox.org/ticket/819), [docs.mongodb.org](https://docs.mongodb.com/manual/administration/production-notes/#fsync-on-directories) and related [jira.mongodb.org](https://jira.mongodb.org/browse/SERVER-8600) bug). This means that it is not possible to run a MongoDB container with the data directory mapped to the host.

#### 解决

创建 volume，docker-compose.yml 

```
version: '3'
services:
  mongodb:
    image: mongo:latest
    volumes:
      - mongodata:/data/db
volumes:
  mongodata:
    driver: local
```







## Leanote

**注意**：如果 docker-compose.yml 中映射了 mongodb_backup，请手动将 leanote_install_data 目录放到 宿主目录里，否则会导入失败

### Nginx 代理

```sh
server {

    listen 80;

    server_name leanote.lo;

    location / {
        proxy_pass  http://leanote:9000;
        #Proxy Settings
        proxy_redirect     off;
        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_next_upstream error  invalid_header http_500 http_502 http_503 http_504;
        proxy_max_temp_file_size 0;
        proxy_intercept_errors on;
        proxy_connect_timeout      90;
        proxy_send_timeout         90;
        proxy_read_timeout         90;
        proxy_buffering on;
        proxy_buffer_size          128k;
        proxy_buffers              8 128k;
        proxy_busy_buffers_size    256k;
        proxy_temp_file_write_size 1024k;
    }

    error_log /var/log/nginx/leanote_error.log;
    access_log /var/log/nginx/leanote_access.log;
}
```

### MongoDB tool 地址

后台指定mongodb 地址

```sh
/usr/bin/mongodump
/usr/bin/mongorestore
```

### Wkhtmltopdf 地址

```sh
/usr/bin/wkhtmltopdf
```



## Seafile Pro



### Nginx 代理

```sh
server {
    listen            80;
    server_name       seafile.lo;

    access_log        off;
    error_log         stderr;

    location / {
        proxy_pass          http://seafile-pro:8000;
        proxy_redirect      off;
        proxy_set_header    Host $host;
        # possibly change/remove next lines to fix wrong ip being shown behind nginx -> seafile
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Host $server_name;
    }

    # only needed when running behind fast-cgi and serving assets via nginx
    #location /media {
    #    root /seafile/server/seahub;
    #}

    location /seafhttp {
        rewrite ^/seafhttp(.*)$ $1 break;
        proxy_pass http://seafile-pro:8082;
        client_max_body_size 0;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_request_buffering off;
        proxy_connect_timeout  36000s;
        proxy_read_timeout  36000s;
        proxy_send_timeout  36000s;

        send_timeout  36000s;
    }

    location /seafdav {
        #rewrite ^/seafdav(.*)$ $1 break;
        #proxy_pass http://seafile-pro:8080;
        #client_max_body_size 0;
        fastcgi_pass    seafile-pro:8080;
        fastcgi_param   SCRIPT_FILENAME     $document_root$fastcgi_script_name;
        fastcgi_param   PATH_INFO           $fastcgi_script_name;

        fastcgi_param   SERVER_PROTOCOL     $server_protocol;
        fastcgi_param   QUERY_STRING        $query_string;
        fastcgi_param   REQUEST_METHOD      $request_method;
        fastcgi_param   CONTENT_TYPE        $content_type;
        fastcgi_param   CONTENT_LENGTH      $content_length;
        fastcgi_param   SERVER_ADDR         $server_addr;
        fastcgi_param   SERVER_PORT         $server_port;
        fastcgi_param   SERVER_NAME         $server_name;

        client_max_body_size 0;
        proxy_connect_timeout  36000s;
        proxy_read_timeout  36000s;
        proxy_send_timeout  36000s;
        send_timeout  36000s;

        # This option is only available for Nginx >= 1.8.0. See more details below.
        proxy_request_buffering off;

        access_log      /var/log/nginx/seafdav.access.log;
        error_log       /var/log/nginx/seafdav.error.log;    
    }

}
```


## Tideways

### 启动 Tideways Daemon容器

```sh
docker-compose up -d tideways
```

### 开启 Tideways PHP扩展

> https://github.com/tideways/php-xhprof-extension.git

```sh
# vim .env
PHP_FPM_INSTALL_TIDEWAYS=true
# 重新build php-fpm
```

### 安装 xhgui

> 需要 MongoDB 支持

#### 安装

```sh
git clone https://github.com/laynefyc/xhgui-branch.git
cd xhgui-branch
composer install --prefer-dist
# xhgui-branch/cache 需要777权限
```

#### 配置

`/config/config.default.php`

```php
    /*
     * support extension: uprofiler, tideways_xhprof, tideways, xhprof
     * default: xhprof
     */
    'extension' => 'tideways',

    // Can be either mongodb or file.
    /*
    'save.handler' => 'file',
    'save.handler.filename' => dirname(__DIR__) . '/cache/' . 'xhgui.data.' . microtime(true) . '_' . substr(md5($url), 0, 6),
    */
    'save.handler' => 'mongodb',

    // Needed for file save handler. Beware of file locking. You can adujst this file path
    // to reduce locking problems (eg uniqid, time ...)
    //'save.handler.filename' => __DIR__.'/../data/xhgui_'.date('Ymd').'.dat',
    'db.host' => 'mongodb://mongo:27017',
    'db.db' => 'xhprof',
```

#### MongoDB优化

```sh
$ mongo
> use xhprof
> db.results.ensureIndex( { 'meta.SERVER.REQUEST_TIME' : -1 } )
> db.results.ensureIndex( { 'profile.main().wt' : -1 } )
> db.results.ensureIndex( { 'profile.main().mu' : -1 } )
> db.results.ensureIndex( { 'profile.main().cpu' : -1 } )
> db.results.ensureIndex( { 'meta.url' : 1 } )
```

#### Nginx

一是添加PHP_VALUE，告诉PHP程序在执行前要调用服务

**注意：该参数是影响php-fpm全局的**

```ini
server {
    listen 80;
    server_name site.localhost;
    root /var/www/awesome-thing/app/webroot/;
    fastcgi_param PHP_VALUE "auto_prepend_file=/var/www/xhgui-branch/external/header.php";
}
```

xhgui web server

```ini
server {

    listen 80;

    server_name xhgui.lo;
    root /var/www/xhgui-branch/webroot;
    index index.php index.html index.htm;

    location / {
        if (!-e $request_filename) {
            rewrite . /index.php last;
        }
    }

    location ~ \.php$ {
        try_files $uri /index.php =404;
        fastcgi_pass php-fpm7.2:9000;
        fastcgi_index index.php;
        fastcgi_buffers 16 16k;
        fastcgi_buffer_size 32k;
        fastcgi_split_path_info ^((?U).+\.php)(/?.+)$;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
        include fastcgi_params;
    }
}
```

