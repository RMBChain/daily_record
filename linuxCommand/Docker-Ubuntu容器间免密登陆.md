# 免密(证书)登陆原理
把自己的证书公钥放到服务器的信任列表(authorized_keys)中。

本例子演示docker使用相同的公钥和私钥，达到交换公钥的目的。

也就是所有容器使用相同的公钥和私钥。 

注意坑：需要使用 chown 把 /home/hadoop/和/home/hadoop/.ssh 的所有者设置为hadoop。

# 1. 构建基础镜像
```
docker run --rm --name ubuntu_openssh -it ubuntu:18.04 bash
apt -y update
apt-get -y install openssh-server vim
```

在宿主机另开一个窗口执行。
```
docker commit ubuntu_openssh ubuntu_openssh:18.04
docker rm -f ubuntu_openssh
```

# 2. 运行容器
```
docker network create -d bridge ssh-network
docker run --rm -it --name ssh1 --hostname ssh1 --network ssh-network ubuntu_openssh:18.04 bash
docker run --rm -it --name ssh2 --hostname ssh2 --network ssh-network ubuntu_openssh:18.04 bash
```

# 3. 修改每个容器中的配置
```
vim /etc/ssh/sshd_config
```

修改完如下
```
PubkeyAuthentication yes
AuthorizedKeysFile   .ssh/authorized_keys .ssh/authorized_keys2
```

# 4. 重启 ssh 服务
```
service ssh restart
```

# 5. 在每个容器中创建用户
```
mkdir /home/hadoop         # 创建用户目录
mkdir /home/hadoop/.ssh/    # 创建用户目录
useradd -d /home/hadoop -u 10201 -g 102 hadoop
```

# 6. 将用户目录的所有者设置为hadoop
```
chown hadoop /home/hadoop/
chown hadoop /home/hadoop/.ssh/
```

# 7. 生成公钥和私钥，并加入信任列表(authorized_keys)列表中。
在ssh1容器中执行
```
su hadoop
cd /home/hadoop/.ssh/

ssh-keygen -t rsa -N '' -f id_rsa -q # 免交互
cat id_rsa.pub >> authorized_keys
cat authorized_keys

```

# 8. 分发公钥和私钥及authorized_keys
在docker宿主机执行
```
docker cp ssh1:/home/hadoop/.ssh/authorized_keys . #将文件copy出来
docker cp ssh1:/home/hadoop/.ssh/id_rsa          . #将文件copy出来
docker cp ssh1:/home/hadoop/.ssh/id_rsa.pub      . #将文件copy出来

docker cp authorized_keys ssh2:/home/hadoop/.ssh/authorized_keys # 进行分发
docker cp id_rsa          ssh2:/home/hadoop/.ssh/id_rsa          # 进行分发
docker cp id_rsa.pub      ssh2:/home/hadoop/.ssh/id_rsa.pub      # 进行分发

```

使用root用户将证书文件的所有者设置为hadoop
```
chown hadoop /home/hadoop/.ssh/*
```

# 9. 免密(证书)登陆
当前用户是hadoop时，进行连接
```
su hadoop
ssh -o stricthostkeychecking=no hadoop@ssh1 # 免交互
ssh -o stricthostkeychecking=no hadoop@ssh2 # 免交互

ssh hadoop@ssh1
ssh hadoop@ssh2

ssh -i id_rsa hadoop@ssh1
ssh -i id_rsa hadoop@ssh2
```

当前用户是root时，进行连接
```
cd /home/hadoop/.ssh/
ssh -i id_rsa -o stricthostkeychecking=no hadoop@ssh1 # 免交互
ssh -i id_rsa -o stricthostkeychecking=no hadoop@ssh2 # 免交互

ssh -i id_rsa hadoop@ssh1
ssh -i id_rsa hadoop@ssh2

ssh -i id_rsa hadoop@ssh1
ssh -i id_rsa hadoop@ssh2
```

# A. 调试
```
ssh -v hadoop@ssh1
```
