# 下载及参考
  https://minikube.sigs.k8s.io/docs/start/
  https://www.shangmayuan.com/a/ce7fc2c4adad4f8b81f13a59.html

# 启动 
```
minikube delete
minikube start --force --driver docker \
  --registry-mirror https://docker.mirrors.ustc.edu.cn \
  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

```


