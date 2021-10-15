
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


