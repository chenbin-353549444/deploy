#!/bin/bash
# install docker

now=`date +%s`
function log() {
  echo "[$((`date +%s` - now ))] ## $@ ##"
}

log "Installation start at `date`"

# check
[[ `whoami` != "root" ]] && echo "Root Privilege needed, use sudo please." && exit 1
OS=`awk -F= '/^NAME/{print $2}' /etc/os-release | sed "s/\"//g"`
if [[ "$OS" == "Ubuntu" ]];then
  :
elif [[ "$OS" == "CentOS Linux" ]];then
  OS="CentOS"
else
  echo "Unknown OS: \"$OS\", exit"
  exit 2
fi

# install docker
log "install and upgrade docker"
if [[ "$OS" == "Ubuntu" ]];then
  apt-get update
  apt-get -y install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
  add-apt-repository -u "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
  apt-get -y install docker-ce
fi

if [[ "$OS" == "CentOS" ]];then
  yum install -y yum-utils device-mapper-persistent-data lvm2
  yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
  yum makecache fast
  yum -y install docker-ce
  systemctl enable docker && systemctl start docker  
fi

# congifure mirror and insecure registries
log "congifure mirror and insecure registries"
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://m.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload && systemctl restart docker
log "Installation end at `date`"
