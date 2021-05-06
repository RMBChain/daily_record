#### 格式化第二块硬盘
# 查看硬盘
fdisk -l
lsblk
# 格式化硬盘
mkfs -t ext4 /dev/vdb
# mount硬盘到目录
mkdir /secondDisk
mount /dev/vdb /secondDisk
#umount /dev/vdb /secondDisk
# 开机自动挂载，在/etc/fstab中追加
/dev/vdb  /secondDisk   ext4 defaults 0 0

#### ubuntu 设置root用户名
sudo passwd root


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


