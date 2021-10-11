# 下载及安装
  https://minikube.sigs.k8s.io/docs/start/


# 启动 
```
minikube stop
minikube delete
# minikube start --vm-driver=none --registry-mirror=https://docker.mirrors.ustc.edu.cn # in aliyun
# minikube start --driver=hyperv --registry-mirror=https://docker.mirrors.ustc.edu.cn # in windows
minikube start --force --driver=docker --registry-mirror=https://registry.docker-cn.com # in wsl2

```

# 启动 webui
```
minikube dashboard
```

# 查看集群
```
minikube kubectl -- get po -A
```

# 创建kubectl快捷方式
```
alias kubectl="minikube kubectl --"
```

# 创建deployment并expose
```
minikube kubectl -- create deployment hello-minikube1 --image=nginx:latest
minikube kubectl -- expose deployment hello-minikube1 --type=NodePort --port=80
```

# 查看服务
```
kubectl get services hello-minikube1
kubectl get services
```

# 发布服务
```
minikube service hello-minikube1
```

# 转发服务
```
minikube kubectl -- port-forward service/hello-minikube1 9080:8080
```
