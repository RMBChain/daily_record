
# server 安装
https://github.com/hwdsl2/docker-ipsec-vpn-server/blob/master/README-zh.md

# 客户端配置
https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients-zh.md

# 步骤：
安装docker
```
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

yum install -y yum-utils device-mapper-persistent-data lvm2
yum install docker
```

# 启动docker
```
systemctl daemon-reload
systemctl restart docker.service

systemctl start docker
systemctl enable docker
```

# 运行docker镜像
```
docker run \
    --name ipsec-vpn-server \
    --restart=always \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -d --privileged \
    hwdsl2/ipsec-vpn-server
```

# 获取vpn登录信息
docker logs ipsec-vpn-server

# 获取vpn server状态


# 查看当前已建立的 VPN 连接：
```
docker exec -it ipsec-vpn-server ipsec whack --trafficstatus
```

# =
```
IPsec VPN server is now ready for use!
Connect to your new VPN with these details:
Server IP: 47.244.51.215
IPsec PSK: Ypw5zBWFDecYkcx8YXDu
Username: vpnuser
Password: fSzcusakRDixzqKj
Write these down. You'll need them to connect!
Important notes:   https://git.io/vpnnotes2
Setup VPN clients: https://git.io/vpnclients
```

# 设置win10
```
https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients-zh.md
别忘了运行注册表 REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
```