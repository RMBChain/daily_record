# 免密(证书)登陆原理
把自己的证书公钥放到服务器的信任列表(authorized_keys)中。

本例子演示两个docker交换公钥

# 1. 运行两个容器
```
docker network create -d bridge ssh-network
docker run --rm -it --name ssh1 --hostname ssh1 -p 1022:22 --network ssh-network ubuntu:18.04 bash
docker run --rm -it --name ssh2 --hostname ssh2 -p 2022:22 --network ssh-network ubuntu:18.04 bash
```

# 2. 在容器中安装服务
```
apt -y update
apt-get -y install openssh-server vim
```

# 3. 修改两个容器中的配置
```
vim /etc/ssh/sshd_config
```
修改完如下
```
PermitRootLogin yes
PubkeyAuthentication yes
AuthorizedKeysFile   .ssh/authorized_keys .ssh/authorized_keys2
```

# 4. 重启 ssh 服务
```
service ssh restart
```

# 5. 生成公钥和私钥
```
mkdir ~/.ssh && cd ~/.ssh
ssh-keygen -t rsa -N '' -f id_rsa -q # 免交互
```

# 6. 将自己的公钥(id_rsa.pub)发送给对方。在宿主机执行
将ssh1的公钥copy到ssh2
```
docker cp ssh1:/root/.ssh/id_rsa.pub ssh1_id_rsa.pub
docker cp ssh1_id_rsa.pub ssh2:/root/.ssh/ssh1_id_rsa.pub
```

将ssh2的公钥copy到ssh1
```
docker cp ssh2:/root/.ssh/id_rsa.pub ssh2_id_rsa.pub
docker cp ssh2_id_rsa.pub ssh1:/root/.ssh/ssh2_id_rsa.pub
```

# 7. 将对方的公钥添加到信任列表(authorized_keys)列表中。
在ssh1中执行
```
cat ssh2_id_rsa.pub >> authorized_keys
cat authorized_keys
```

在ssh2中执行
```
cat ssh1_id_rsa.pub >> authorized_keys
cat authorized_keys
```

# 8. 免密(证书)登陆
在ssh1中执行
```
ssh -o stricthostkeychecking=no root@ssh2
```

在ssh2中执行
```
ssh -o stricthostkeychecking=no root@ssh1
```
