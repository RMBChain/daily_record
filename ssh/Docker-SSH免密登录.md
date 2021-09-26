
# 1. 构建基础镜像
```
docker build -t openssh-server:v1 .
```

# 2. 启动
```
docker network create -d bridge ssh_network

docker run -it --rm --name ssh1 --hostname ssh1 --network ssh_network -p 22:22 openssh-server:v1 bash -c "service ssh start && bash"
docker run -it --rm --name ssh2 --hostname ssh2 --network ssh_network          openssh-server:v1 bash -c "service ssh start && bash"
docker run -it --rm --name ssh3 --hostname ssh3 --network ssh_network          openssh-server:v1 bash -c "service ssh start && bash"

```

# 3. 测试:在每个容器内执行下面的命令
免第一次登录时的确认(第一次免交互)
```
ssh -o stricthostkeychecking=no ssh1
ssh -o stricthostkeychecking=no ssh2
ssh -o stricthostkeychecking=no ssh3
```

需确认
```
ssh ssh1
ssh ssh2
ssh ssh3
```

# 4. 说明
证书放在对应用户目录的.ssh文件夹中。比如root用户的ssh相关信息放在 /root/.ssh 下

文件说明:
- authorized_keys 把证书的公钥放到这里后，就可以用私钥登录了
- id_rsa root用户的私钥，把这个文件给别人，别人就可以登录了。
- id_rsa.pub root用户的公钥，把这个文件放到authorized_keys中后，就可以使用对应的私钥进行登录了。

