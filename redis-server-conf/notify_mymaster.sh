#!/bin/bash

echo "File Name: $0"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"

MASTER_IP=${6}  #第六个参数是新主redis的ip地址
LOCAL_IP='192.168.0.132'  #当前服务器IP，主机172.16.2.185，从机172.16.2.181
VIP='192.168.0.200'
NETMASK='24'
INTERFACE='enp3s0'
if [ ${MASTER_IP} = ${LOCAL_IP} ]; then
     sudo /sbin/ip addr add ${VIP}/${NETMASK} dev ${INTERFACE}  #将VIP绑定到该服务器上
     sudo /sbin/arping -q -c 3 -A ${VIP} -I ${INTERFACE}
    exit 0
else
     sudo /sbin/ip addr del ${VIP}/${NETMASK} dev ${INTERFACE}   #将VIP从该服务器上删除
   exit 0
fi
exit 1  #如果返回1，sentinel会一直执行这个脚本

