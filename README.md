# 运行

### 安装 docker 

```bash
curl -L get.docker.io | bash
```

### 运行 mysql 容器

```bash
curl -L -O https://raw.githubusercontent.com/serenader2014/ss-panel-v3-mod/new_master/sql/glzjin_all.sql
mv glzjin_all.sql /etc/mysql

docker run --name mysql -d --restart always \
  -v /etc/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -p 3306:3306 \
  mysql:5.5
```

### 运行 redis 容器

```bash

```

### 初始化数据

```bash
docker exec -it mysql /bin/bash -c "mysqladmin -p$MYSQL_ROOT_PASSWORD create $SS_DB_NAME"
docker exec -it mysql /bin/bash -c "mysql -u root -p$MYSQL_ROOT_PASSWORD $SS_DB_NAME < /var/lib/mysql/glzjin_all.sql"
```

### 运行 ss-panel-v3-mod 容器

```bash
docker run --name ss-panel -p 7000:80 \
    -e APP_NAME=ss -e KEY=sspanel -e BASE_URL=la.serenader.me:7000 -e MYSQL_HOST=mysql \
    -e MYSQL_DB=$SS_DB_NAME -e MYSQL_USERNAME=root -e MYSQL_PASSWORD=$MYSQL_PASSWORD serenader/ss-panel-v3-mod
```

### 创建管理员账号

```bash
docker exec -it ss-panel php -n /var/www/html/xcat createAdmin
```


### 运行 ssserver

```bash
docker run -d --name ss-many --restart always \
    --network host \
    -e NODE_ID=$NODE_ID \
    -e MYSQL_HOST=$MYSQL_HOST \
    -e MYSQL_PORT=$MYSQL_PORT \
    -e MYSQL_USER=$MYSQL_USER \
    -e MYSQL_PASS=$MYSQL_PASS \
    -e MYSQL_DB=$MYSQL_DB \
    serenader/ss-manyuser-docker
```

NODE_ID 的值可以从 ss-panel-v3-mod 上创建一个新节点得到一个新的 ID。 mysql 连接信息则为 mysql 容器的连接信息
