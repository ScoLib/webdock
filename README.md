# webdock

```sh
copy env-example .env
```

```sh
docker-compose up -d --no-deps php-fpm7.2 php-fpm5.6 mysql nginx 
```


```sh
docker-compose build --force-rm php-fpm5.6
```

## Xdebug

PHPSTORM 配置 `.env` 中 `PHP_IDE_CONFIG` 参数serverName同名的server，并设置path映射

`.env` 配置 `DOCKER_HOST_IP`

`xdebug.ini` 修改

```ini
xdebug.remote_host=dockerhost # 开启
xdebug.remote_connect_back=0 # 关闭
```