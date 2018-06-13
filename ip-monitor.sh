#!/bin/bash

echo ""  >/pjtest/record.txt
echo `date` >  /pjtest/`date +%Y%m%d`alive-list.txt
echo `date` >  /pjtest/`date +%Y%m%d`down-list.txt
nmap -sP 192.168.4.0/24 >>  /pjtest/record.txt

for i in {1..254}
do
grep -w  "192.168.4.$i" /pjtest/record.txt  &> /dev/null
if [ $? -eq 0 ];then
   echo  "host$i is alive" >> /pjtest/`date +%Y%m%d`alive-list.txt
else
   echo  "host$i is down" >> /pjtest/`date +%Y%m%d`down-list.txt
fi
done

mail -s "Report-alive" 410244950@qq.com < /pjtest/`date +%Y%m%d`alive-list.txt
mail -s "Report-down" 410244950@qq.com < /pjtest/`date +%Y%m%d`down-list.txt
