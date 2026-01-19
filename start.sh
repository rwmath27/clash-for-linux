#参考https://gemini.google.com/share/e6f8fd4b6c26

#!/bin/bash

# 获取当前脚本所在目录
Server_Dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
Conf_Dir="$Server_Dir/conf"
Temp_Dir="$Server_Dir/temp"
Log_Dir="$Server_Dir/logs"
# 自动识别当前目录下的 clash 可执行文件
Clash_Bin="$Server_Dir/clash-linux-amd64-v1.3.5"

# 订阅地址
URL='https://subconverters.com/sub?target=clash&url=ssr%3A%2F%2FNjQuMTc2LjE2OS4xNzA6NjU0MzphdXRoX2FlczEyOF9tZDU6YWVzLTI1Ni1jZmI6dGxzMS4yX3RpY2tldF9mYXN0YXV0aDpkR3BzWVdJeU1qSS8%2FcmVtYXJrcz0mcHJvdG9wYXJhbT0mb2Jmc3BhcmFtPQ&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini&emoji=true&list=false&xudp=false&udp=false&tfo=false&expand=true&scv=false&fdn=false&new_name=true'

# 自定义的状态检查函数 (适配所有 Linux 发行版)
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "\033[32m[OK]\033[0m $1"
    else
        echo -e "\033[31m[Error]\033[0m $2"
        exit 1
    fi
}

# 确保目录存在
mkdir -p $Temp_Dir
mkdir -p $Log_Dir
mkdir -p $Conf_Dir

# 临时取消环境变量，防止 wget 走代理导致下载死循环
unset http_proxy
unset https_proxy

echo "正在下载配置文件..."
# 拉取更新 clash.yaml 文件
wget -q -O "$Temp_Dir/clash.yaml" "$URL"
check_status "配置文件下载成功！" "配置文件下载失败，请检查网络或URL！"

# 取出代理相关配置
sed -n '/^proxies:/,$p' "$Temp_Dir/clash.yaml" > "$Temp_Dir/proxy.txt"

# 合并形成新的 config.yaml
# 注意：前提是 temp 目录下必须有 templete_config.yaml，如果没有会报错
if [ -f "$Temp_Dir/templete_config.yaml" ]; then
    cat "$Temp_Dir/templete_config.yaml" > "$Temp_Dir/config.yaml"
    cat "$Temp_Dir/proxy.txt" >> "$Temp_Dir/config.yaml"
    \cp "$Temp_Dir/config.yaml" "$Conf_Dir/"
else
    # 如果没有模板，直接使用下载的文件
    echo "未找到模板文件，直接使用下载的配置。"
    \cp "$Temp_Dir/clash.yaml" "$Conf_Dir/config.yaml"
fi

# 赋予执行权限
chmod +x "$Clash_Bin"

# 启动 Clash 服务
# 使用变量引用的路径，而不是硬编码路径
nohup "$Clash_Bin" -d "$Conf_Dir" > "$Log_Dir/clash.log" 2>&1 &
check_status "Clash 服务启动成功！" "Clash 服务启动失败！"

# 添加环境变量
echo -e "export http_proxy=http://127.0.0.1:7890\nexport https_proxy=http://127.0.0.1:7890" > /etc/profile.d/clash.sh
echo -e "系统代理 http_proxy/https_proxy 设置成功，请在当前窗口执行以下命令加载环境变量:\n"
echo -e "source /etc/profile.d/clash.sh\n"
