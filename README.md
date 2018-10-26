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

Window下使用时，使用 volumes 映射宿主机目录到 `/data/db`，会报如下错误：

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

原因见： https://stackoverflow.com/questions/42756776/how-do-i-configure-mongo-to-run-in-docker-to-using-an-external-drive-on-windows

**目前Windows只能暂时不用 volumes** 



## Leanote

### 导入数据库

首次使用时，需要导入 `leanote` 的数据库

```sh
cp ./leanote/docker-entrypoint-initdb.d/init.sh.example ./leanote/docker-entrypoint-initdb.d/init.sh
```

**注意**：如果 docker-compose.yml 中映射了 mongodb_backup，请手动将 leanote_install_data 目录放到 宿主目录里，否则会导入失败

### 映射配置

```sh
cp ./leanote/conf/app.conf.example ./leanote/conf/app.conf
```

并根据自己实际情况修改

