# 免密(证书)登陆原理
把自己的证书公钥放到服务器的信任列表(authorized_keys)中。

本例子演示docker使用映射到同一个目录，达到交换公钥的目的。

也就是所有容器使用相同的公钥和私钥。


# 1. 运行容器
```
docker network create -d bridge ssh-network
docker run --rm -it -v $PWD/.ssh:/root/.ssh/ --name ssh1    --hostname ssh1    --network ssh-network ubuntu:18.04 bash
docker run --rm -it -v $PWD/.ssh:/root/.ssh/ --name ssh2    --hostname ssh2    --network ssh-network ubuntu:18.04 bash
```

# 2. 在容器中安装服务
```
apt -y update
apt-get -y install openssh-server vim
```

# 3. 修改每个容器中的配置
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

# 5. 生成公钥和私钥，并加入信任列表(authorized_keys)列表中。
只在其中一个容器中运行下面的命令即可
```
cd ~/.ssh
ssh-keygen -t rsa -N '' -f id_rsa -q # 免交互
cat id_rsa.pub >> authorized_keys
```

# 6. 免密(证书)登陆
在任意一个容器中执行
```
ssh -o stricthostkeychecking=no root@ssh2
ssh -o stricthostkeychecking=no root@ssh1
```
