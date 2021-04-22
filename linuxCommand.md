#### 格式化第二块硬盘
# 查看硬盘
lsblk
# 格式化硬盘
mkfs -t ext4 /dev/vdb
# 挂在硬盘到目录
mount /dev/vdb /cherry


