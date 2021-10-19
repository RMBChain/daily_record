建立私有仓库
```
// https://verdaccio.org/docs/installation/
docker run -d --name verdaccio -p 4873:4873 verdaccio/verdaccio
// http://0.0.0.0:4873/
// npm set registry http://localhost:4873 && npm get registry
// npm --registry http://localhost:4873/ install [依赖的名称]
// yarn config set registry http://localhost:4873 && yarn config get registry //如果不生效，查看 .yarnrc 和 yarn.lock 文件
// yarn install --registry http://localhost:4873
```

使用docker运行node
```
docker run -it --rm --net host -v $PWD:/workspace -w /workspace node:10.24.1 bash
```

临时使用taobao或其他镜像
```
npm --registry https://registry.npm.taobao.org install [依赖的名称]
npm --registry http://localhost:4873           install [依赖的名称]
```

安装CNPM
```
# npm install -g cnpm
npm install -g cnpm -registry=https://registry.npm.taobao.org
```

npm国内镜像
```
// huaweicloud
npm config set registry        https://mirrors.huaweicloud.com/repository/npm/
npm config set disturl         https://mirrors.huaweicloud.com/nodejs/
npm config set electron_mirror https://mirrors.huaweicloud.com/electron/


// taobao
npm config set registry        https://registry.npm.taobao.org
npm config set disturl         https://npm.taobao.org/dist
npm config set electron_mirror https://npm.taobao.org/mirrors/electron/

```

yarn国内镜像
```
// huaweicloud
yarn config set registry        https://mirrors.huaweicloud.com/repository/npm/
yarn config set disturl         https://mirrors.huaweicloud.com/nodejs/
yarn config set electron_mirror https://mirrors.huaweicloud.com/electron/
yarn config get registry

// taobao
yarn config set registry        https://registry.npm.taobao.org
yarn config set disturl         https://npm.taobao.org/dist
yarn config set electron_mirror https://npm.taobao.org/mirrors/electron/

```


yarn第三方工具yrm管理镜像源
```
npm install -g yrm
yrm ls // 列出可用源
yrm use taobao

yrm add local http://127.0.0.1:4873 //添加源
yrm use local

```
