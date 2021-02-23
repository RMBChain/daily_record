# 配置nginx的https：使用 docker安装openssl，然后发行证书。
# https://blog.csdn.net/weixin_33694620/article/details/92906091
# https://www.it610.com/article/1279427628222136320.htm


# 启动docker
docker rm -f openssl
docker run -it -d -p 8989:80 -p 443:443 --name openssl ubuntu:16.04
docker exec -it openssl bash


# 设置ubuntu16的国内进行源
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://mirrors.aliyun.com/ubuntu xenial           main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu xenial-updates   main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu xenial-security  main restricted universe multiverse" >> /etc/apt/sources.list
# 更新源
apt -y update


# 安装openssl和nginx
apt -y install openssl nginx curl
# 验证openssl
openssl version
# 启动并验证nginx
nginx && curl localhost


# 制作证书
cd /etc/nginx
# 生成key,也就是pem，也就是私钥
openssl genrsa -out https_nginx.key 2048   
# 生成csr, 也就是证书签名请求
openssl req -new -key https_nginx.key -out https_nginx.csr -subj "/C=CN/ST=Dalian/L=Dalian/O=nginx Inc./OU=Web Security/CN=cn"
# 生成crt, 也就是证书文件
openssl x509 -req -days 3650 -in https_nginx.csr -signkey https_nginx.key -out https_nginx.crt


# 修改 nginx.conf 文件
vi /etc/nginx/nginx.conf
```bash
    server {
        listen 80;
        listen [::]:80;
        rewrite ^(.*)$ https://$host$1 permanent;
    }

    server {
        # SSL configuration
        #
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;

        ssl on;
        ssl_certificate     /etc/nginx/https_nginx.crt;
        ssl_certificate_key /etc/nginx/https_nginx.key;
	    server_name localhost;
        root html;
        index index.html index.htm;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        location / {
            root html;
            index index.html index.htm;
        }
    }

```
# 验证nginx.conf格式
nginx -t
# 重新加载nginx
nginx -s reload
nginx -s reopen


# 重新验证 https-nginx
curl -k https://localhost

