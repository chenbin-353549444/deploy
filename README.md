# deploy
放一些脚本

### 一键安装docker
需要 Ubuntu 14.04+ || CentOS 7+
```bash
bash <(curl -fSsL http://www.chenb.top/deploy/docker-install.sh)
```

### 启动jenkins容器
```bash
docker run \
  --name jenkins \
  -d \
  -u root \
  -p 8080:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e TZ=Asia/Shanghai \
  -v "$HOME":/home \
  jenkinsci/blueocean
```

### 启动mysql容器
```bash
docker run \
  --name mysql_prod \
  -d \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=Hongfund5013 \
  -e MYSQL_USER=hongfund_os \
  -e MYSQL_PASSWORD=hongfund_os_5013 \
  -e MYSQL_DATABASE=efi \
  -v /mysql_prod:/var/lib/mysql \
  mysql:5.7.18 \
  --character-set-server=utf8mb4 \
  --collation-server=utf8mb4_unicode_ci
```
