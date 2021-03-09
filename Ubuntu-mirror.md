###################### Ubuntu16
#阿里源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://mirrors.aliyun.com/ubuntu xenial           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu xenial-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu xenial-security  main restricted universe multiverse" >> /etc/apt/sources.list
```

###################### Ubuntu18
#阿里源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     http://mirrors.aliyun.com/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
```


#网易源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     http://mirrors.163.com/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.163.com/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.163.com/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.163.com/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.163.com/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.163.com/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.163.com/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.163.com/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
```


#清华源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
```


##中科大源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     https://mirrors.ustc.edu.cn/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.ustc.edu.cn/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
```


###################### Ubuntu19
#清华源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ eoan-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
```


###################### Ubuntu20
#阿里源
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
<<<<<<< HEAD

#清华源
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list

mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb     https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security  main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security  main restricted universe multiverse" >> /etc/apt/sources.list
=======
```
>>>>>>> d0710a9277ebcd9ee4d689e15bb65d2102f7e1ca

