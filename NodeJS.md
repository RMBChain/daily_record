
# 建立自己的npm镜像服务器 https://cloud.tencent.com/developer/article/1722254
```
npm install -g verdaccio 
verdaccio 
npm config set registry http://localhost:4873/
npm adduser
npm install

```

# npm和yarn转换淘宝源和官方源
```
npm config set registry http://registry.npm.taobao.org/
npm config set registry https://registry.npmjs.org/

yarn config set registry http://registry.npm.taobao.org/
yarn config set registry https://registry.npmjs.org/
```

# npm 设置代理
```
npm config set proxy http://127.0.0.1:8080
npm config set https-proxy http://127.0.0.1:8080
```

# npm 删除代理
```
npm config delete proxy
npm config delete https-proxy
```

# yarn 设置代理
```
yarn config set proxy http://127.0.0.1:8080
yarn config set https-proxy http://127.0.0.1:8080
```

# yarn 删除代理
```
yarn config delete proxy
yarn config delete https-proxy
```
