
# 启动容器
```
docker network create -d bridge ssh-network
docker run --rm -it --name ssh1 --hostname ssh1 -p 1022:22 --network ssh-network ubuntu:18.04 bash
docker run --rm -it --name ssh2 --hostname ssh2 -p 2022:22 --network ssh-network ubuntu:18.04 bash
```

# 容器内安装软件
```
apt -y update
apt-get -y install openssh-server openssh-client vim inetutils-ping
```

# 容器内修改配置
```
vim /etc/ssh/sshd_config
```
修改 PermitRootLogin 为 yes。 允许root认证登录

# 容器内重启ssh服务
```
service ssh restart
```

# 容器内修改密码
```
passwd
```

# 容器内登陆
```
ssh root@localhost
```

# 容器外登陆
```
ssh root@ssh1
ssh root@ssh2
```

# Docker外登陆
```
ssh root@IP -p 1022
ssh root@IP -p 2022
```


