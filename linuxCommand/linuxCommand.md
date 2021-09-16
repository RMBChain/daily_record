# 格式化第二块硬盘
## 查看硬盘
``` 
fdisk -l
lsblk
``` 

## 格式化硬盘
``` 
mkfs -t ext4 /dev/vdb
``` 

## mount硬盘到目录
``` 
mkdir /secondDisk
mount /dev/vdb /secondDisk
#umount /dev/vdb /secondDisk
``` 

## 开机自动挂载，在/etc/fstab中追加
``` 
/dev/vdb  /secondDisk   ext4 defaults 0 0
``` 

# 批量更新git
``` bash
baseDir=`pwd`
#ls | while read file
for file in $(ls) 
do
  echo $file
  if [ -d $file ] ; then
    cd $file
    git pull
    cd $baseDir
  fi
done
```

# 使用ssh访问远程主机
## 方式一 将证书添加到本地
```
# 添加证书
eval `ssh-agent`
ssh-add -k xxxxx.pem

# 访问主机
ssh root@47.242.46.201
```

## 方式二 通过命令指定证书
```
# **在wsl下使用时，需要把证书放到linux的盘符下**
chmod 600 xxxx.pem
ssh-agent bash
ssh-add xxxx.pem
ssh root@172.19.0.2 // or ssh -i xxxx.pem root@172.19.0.2
```
