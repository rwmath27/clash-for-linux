# 项目介绍
此项目是通过使用开源项目[clash](https://github.com/Dreamacro/clash)作为核心程序，再结合脚本实现简单的代理功能。  
主要是为了解决我们在服务器上下载GitHub等一些国外资源速度慢的问题。
# 使用教程
### 下载项目
下载项目
```
https://github.com/rwmath27/clash-for-linux.git
```
进入到项目目录，编辑`start.sh`脚本文件，修改变量`URL`的值。
```bash
cd clash-for-linux
vim start.sh
```
### 启动程序
直接运行脚本文件`start.sh`
- 进入项目目录
```bash
cd clash-for-linux
```
- 运行启动脚本
```bash
bash start.sh
```
结果应为
```
配置文件config.yaml下载成功！                              [  OK  ]
服务启动成功！                                             [  OK  ]
系统代理http_proxy/https_proxy设置成功，请在当前窗口执行以下命令加载环境变量:

source /etc/profile.d/clash.sh
```
然后
```bash
source /etc/profile.d/clash.sh
```
- 检查服务端口
```bash
$ netstat -tln | grep -E '9090|789.'
tcp        0      0 127.0.0.1:9090          0.0.0.0:*               LISTEN     
tcp6       0      0 :::7890                 :::*                    LISTEN     
tcp6       0      0 :::7891                 :::*                    LISTEN     
tcp6       0      0 :::7892                 :::*                    LISTEN
```
- 检查环境变量
```bash
$ env | grep -E 'http_proxy|https_proxy'
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
```
以上步鄹如果正常，说明服务clash程序启动成功，现在就可以体验高速下载github资源了。
### 停止程序
- 进入项目目录
```bash
$ cd clash-for-linux
```
- 关闭服务
```bash
$ sh shutdown.sh
服务关闭成功，请在已打开的窗口执行以下命令：
unset http_proxy
unset https_proxy
```
```bash
$ unset http_proxy
$ unset https_proxy
```
然后检查程序端口、进程以及环境变量`http_proxy|https_proxy`，若都没则说明服务正常关闭。
# 使用须知
- 此项目不提供任何订阅信息，请自行准备Clash订阅地址。
- 运行前请手动更改`start.sh`脚本中的URL变量值，否则无法正常运行。
- 当前只在RHEL系列Linux系统中测试过，其他系列可能需要适当修改脚本。

# 过程示例
```
root@autodl-container-bbc64d91a6-9139642a:~# git clone https://github.com/rwmath27/clash-for-linux.git
Cloning into 'clash-for-linux'...
fatal: unable to access 'https://github.com/rwmath27/clash-for-linux.git/': GnuTLS recv error (-110): The TLS connection was non-properly terminated.
root@autodl-container-bbc64d91a6-9139642a:~# git clone https://github.com/rwmath27/clash-for-linux.git
Cloning into 'clash-for-linux'...
fatal: unable to access 'https://github.com/rwmath27/clash-for-linux.git/': Failed to connect to github.com port 443 after 130618 ms: Connection timed out
root@autodl-container-bbc64d91a6-9139642a:~# mkdir test
root@autodl-container-bbc64d91a6-9139642a:~# cd test
root@autodl-container-bbc64d91a6-9139642a:~/test# ls
clash-for-linux.zip
root@autodl-container-bbc64d91a6-9139642a:~/test# unzip clash-for-linux.zip
Archive:  clash-for-linux.zip
2367e8653fc3decb48a8c9432b50838ee47eb949
   creating: clash-for-linux-master/
  inflating: clash-for-linux-master/README.md  
  inflating: clash-for-linux-master/clash-linux-amd64-v1.3.5  
   creating: clash-for-linux-master/conf/
  inflating: clash-for-linux-master/conf/Country.mmdb  
 extracting: clash-for-linux-master/conf/config.yaml  
   creating: clash-for-linux-master/logs/
 extracting: clash-for-linux-master/logs/clash.log  
  inflating: clash-for-linux-master/shutdown.sh  
  inflating: clash-for-linux-master/start.sh  
   creating: clash-for-linux-master/temp/
 extracting: clash-for-linux-master/temp/clash.yaml  
 extracting: clash-for-linux-master/temp/config.yaml  
 extracting: clash-for-linux-master/temp/proxy.txt  
  inflating: clash-for-linux-master/temp/templete_config.yaml  
root@autodl-container-bbc64d91a6-9139642a:~/test# cd clash-for-linux
bash: cd: clash-for-linux: No such file or directory
root@autodl-container-bbc64d91a6-9139642a:~/test# cd clash-for-linux
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# vim start.sh
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# bash start.sh
正在下载配置文件...
[OK] 配置文件下载成功！
[OK] Clash 服务启动成功！
系统代理 http_proxy/https_proxy 设置成功，请在当前窗口执行以下命令加载环境变量:

source /etc/profile.d/clash.sh

root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# source /etc/profile.d/clash.sh
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# git clone https://github.com/rwmath27/clash-for-linux.git
Cloning into 'clash-for-linux'...
remote: Enumerating objects: 44, done.
remote: Counting objects: 100% (25/25), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 44 (delta 15), reused 12 (delta 12), pack-reused 19 (from 1)
Receiving objects: 100% (44/44), 5.23 MiB | 2.48 MiB/s, done.
Resolving deltas: 100% (17/17), done.
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# sh shutdown.sh
-e 服务关闭成功，请在已打开的窗口执行以下命令：
unset http_proxy
unset https_proxy
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# unset http_proxy
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# unset https_proxy
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# git clone https://github.com/rwmath27/clash-for-linux.git
fatal: destination path 'clash-for-linux' already exists and is not an empty directory.
root@autodl-container-bbc64d91a6-9139642a:~/test/clash-for-linux# cd ..
root@autodl-container-bbc64d91a6-9139642a:~/test# cd ..
root@autodl-container-bbc64d91a6-9139642a:~# git clone https://github.com/rwmath27/clash-for-linux.git
Cloning into 'clash-for-linux'...
fatal: unable to access 'https://github.com/rwmath27/clash-for-linux.git/': GnuTLS recv error (-110): The TLS connection was non-properly terminated.
root@autodl-container-bbc64d91a6-9139642a:~#
```
