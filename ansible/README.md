
# 1. 构建基础镜像
```
// docker run --rm -it --net host 
docker build -t ansible-worker -f worker.Dockerfile .
docker build -t ansible-master -f master.Dockerfile .

```

# 2. 运行容器
```
docker network create -d bridge ansible

docker rm -f ansible-master ansible-worker1 ansible-worker2 ansible-worker3
docker run --rm -it --name ansible-master  --hostname ansible-master  --network ansible -w /workspace -v $PWD:/workspace ansible-master bash -c "service ssh start && bash"
docker run --rm -it --name ansible-worker1 --hostname ansible-worker1 --network ansible                                  ansible-worker bash -c "service ssh start && bash"
docker run --rm -it --name ansible-worker2 --hostname ansible-worker2 --network ansible                                  ansible-worker bash -c "service ssh start && bash"
docker run --rm -it --name ansible-worker3 --hostname ansible-worker3 --network ansible                                  ansible-worker bash -c "service ssh start && bash"

```

# 3. 在验证连通性(在 ansible-master 中执行 )
```
ssh -i id_rsa -o stricthostkeychecking=no ansible-worker1
ssh -i id_rsa -o stricthostkeychecking=no ansible-worker2
ssh -i id_rsa -o stricthostkeychecking=no ansible-worker3

ssh ansible-worker1
ssh ansible-worker2
ssh ansible-worker3


ansible -i inventory ansible-worker1 -m ping
ansible -i inventory ansible-worker2 -m ping
ansible -i inventory ansible-worker3 -m ping

ansible -i inventory all -m ping
ansible -i inventory all -m command -a 'uptime'
```

# 4. 使用 shell 模块
```
ansible -i ./inventory all -m shell -a 'apt-get -y update' 
ansible -i ./inventory web -m shell -a 'apt-get -y install nginx' 
ansible -i ./inventory web -m shell -a 'nginx -stop'
ansible -i ./inventory web -m shell -a 'nginx -quit'
ansible -i ./inventory web -m shell -a 'nginx'

curl ansible-worker1
curl ansible-worker3

```


# 5. 使用 playbook
```
ansible-playbook -i ./inventory nginx.yml

curl ansible-worker1
curl ansible-worker3

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
