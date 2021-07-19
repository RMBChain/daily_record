
# wsl 命令参考
https://docs.microsoft.com/en-us/windows/wsl/reference

# 查看证每个发行版使用的 WSL 版本
```
wsl --list --verbose
```
或
```
wsl -l -v
```

# 安装新的 Ubuntu时，先将 WSL 2 设置为默认：
```
wsl --set-default-version 2
```

# 设置默认分发版
```
wsl -s Ubuntu-18.04
```

# 修改默认用户为root  

https://blog.csdn.net/jokeshe/article/details/107239159

# 在powershell中运行
```
Ubuntu1804 config --default-user root
```

# 实现在wsl2中存在多个相同版本的wsl
https://winaero.com/export-import-wsl-linux-distro-windows-10/

https://4sysops.com/archives/export-and-import-windows-subsystem-for-linux-wsl/

# 导出WSL镜像
```
wsl --export Ubuntu ubuntu.tar
```

# 导入WSL镜像 （需要指定全路径）
```
wsl --import Ubuntu-18.04-docker D:\wsl2Distribution\Ubuntu18.04Docker D:\wsl2Distribution\Ubuntu-18.04.tar --version 2
```

# 删除现有的wsl子系统：
```
wsl --unregister Ubuntu-18.04-registry
```

# 运行指定的发现版本
```
wsl -d Ubuntu-18.04-registry
```

# Docker Desktop(WSL2)修改镜像存储位置
https://blog.csdn.net/fleaxin/article/details/109812090


# 限制 windwos wsl内存和cpu使用率?
配置全局WSL选项：C:\Users\<yourUserName>\.wslconfig

https://blog.csdn.net/qq_30054961/article/details/114253895

```
[wsl2]
processors=4
memory=8GB
swap=8GB
localhostForwarding=true
```

# WSL2中安装docker 并开机启动
## 安装
```
apt -y update
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
service docker start
```

## 开机启动: 把以下内容添加到/root/.bashrc 脚本中
```
service docker start
```

# WSL2所在路径
## 安装路径
C:\Users\Administrator\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc

## 虚拟机路径
C:\Users\Administrator\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc\LocalState\ext4.vhdx

## 根路径对应win10路径
????????????

# ubuntu 设置root用户名
sudo passwd root

# WSL2使用xrdp实现图形桌面
https://zhuanlan.zhihu.com/p/149501381


# WSL2 下安装GoLand工具
tar -xzf goland-2017.3.3.tar.gz -C /opt
cd /opt/GoLand-2017.3.3/bin
./goland.sh

# 访问WSL2文件系统
```
\\wsl$
```

# 配置 WSL2 访问 Windows 上的代理
```
https://zhuanlan.zhihu.com/p/153124468
cat /etc/resolv.conf
export ALL_PROXY="http://172.19.80.1:7890"
```


