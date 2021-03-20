#### wsl 命令 https://docs.microsoft.com/en-us/windows/wsl/reference
# 查看证每个发行版使用的 WSL 版本
wsl --list --verbose
或
wsl -l -v

# 安装新的 Ubuntu时，先将 WSL 2 设置为默认：
wsl --set-default-version 2



##### 实现在wsl2中存在多个相同版本的wsl
# https://winaero.com/export-import-wsl-linux-distro-windows-10/
# https://4sysops.com/archives/export-and-import-windows-subsystem-for-linux-wsl/
# export 
wsl --export Ubuntu ubuntu.tar
# import （需要指定全路径）
wsl --import Ubuntu-18.04-registry d:\wsl2 d:\wsl2\ubuntu18.04.tar --version 2
# 删除wsl
wsl --unregister Ubuntu-18.04-registry
# 运行指定的发现版本
wsl -d Ubuntu-18.04-registry

#### Docker Desktop(WSL2)修改镜像存储位置
# https://blog.csdn.net/fleaxin/article/details/109812090
# 导出wsl子系统镜像:
wsl --export docker-desktop docker-desktop.tar
wsl --export docker-desktop-data docker-desktop-data.tar
# 删除现有的wsl子系统：
wsl --unregister docker-desktop
wsl --unregister docker-desktop-data

# 重新创建wsl子系统：
wsl --import docker-desktop d:\your-install-path docker-desktop.tar
wsl --import docker-desktop-data d:\your-install-path docker-desktop-data.tar

# 重新运行docker desktop，然后pull一个镜像，C盘不会变大了。

#### 如何限制 windwos wsl内存和cpu使用率?
# 配置全局WSL选项：C:\Users\<yourUserName>\.wslconfig
# https://blog.csdn.net/qq_30054961/article/details/114253895
[wsl2]
processors=4
memory=8GB
swap=8GB
localhostForwarding=true


