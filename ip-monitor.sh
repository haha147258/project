#!/bin/bash
#Author：chan
#记录文件包含日期标签，防止后面的数据将前面的覆盖
#创建记录文件
echo `date`  >/ip-monitor/record.txt
echo `date` >  /ip-monitor/`date +%Y%m%d`alive-list.txt
echo `date` >  /ip-monitor/`date +%Y%m%d`down-list.txt
#使用nmap快速扫描指定网段，并将记录下内容
nmap -sP 192.168.4.0/24 >>  /ip-monitor/record.txt

#利用for循环将文件进行筛选，并按要求将内容记录到文件中
for i in {1..254}
do
grep -w  "192.168.4.$i" /ip-monitor/record.txt  &> /dev/null
if [ $? -eq 0 ];then
   echo  "host$i is alive" >> /ip-monitor/`date +%Y%m%d`alive-list.txt
else
   echo  "host$i is down" >> /ip-monitor/`date +%Y%m%d`down-list.txt
fi
done

#将记录好的文件发到指定邮箱
mail -s "Report-alive" 410244950@qq.com < /ip-monitor/`date +%Y%m%d`alive-list.txt
mail -s "Report-down" 410244950@qq.com < /ip-monitor/`date +%Y%m%d`down-list.txt
