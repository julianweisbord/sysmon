#!/bin/bash

set -e

bold=$(tput bold)
normal=$(tput sgr0)
if [ $USER != "root" ]
then
  echo "Make sure you are root."
  exit 1
fi

DISK="$(sudo lshw -short | grep 'disk\|volume')"

printf "\nDate: "
i=0
for out in $(date)
do
  i=$((i+1))
  printf "$out "
  if [[ $i == 4 ]]
  then
    break
  fi
done
printf "| Epoch Time: $(date +%s)"
printf "\n\n"
printf "Host on: $(uname -sro)\n\n"

printf "CPU Information:\n"
printf "================\n"

#get model name
for line in $(grep -Fm 1 "$model name" /proc/cpuinfo)
do
 printf "$line "
done
printf "| "
#gives number of cpus
printf "Total "
grep -i "cpu cores" /proc/cpuinfo | sort -u
lscpu | grep -i "Thread(s) per core:" | sort -u
lscpu | grep -i "Architecture:\|CPU family:\|CPU MHz\|L1d cache:\|L1i cache:\|L2 cache:\|L3 cache:" | sort -u
printf "Turbo Boost/Overclock"
sudo dmidecode -t processor | grep "Max Speed"
# cat /var/log/dmesg | grep "MHz processor"

printf "\nMemory Information:\n"
printf "===================\n"
sudo dmidecode --type 17 | grep -i "DD\|Manufacturer\|Speed" | sort -u
#max RAM motherboard can hold
sudo dmidecode --type memory | more | grep "Maximum Capacity"
printf "\n"
free -m
printf "\nDisk Information:\n"
printf "=================\n"
printf "$DISK\n\n"

# motherboard
printf "Motherboard Information:\n"
printf "========================\n"
 sudo dmidecode -t 2 | grep -i "Manufacturer\|Product Name"
 sudo dmidecode -t 4 | grep -i "Socket"

 printf "\nTemperatures C: \n"
 printf "=============\n"
# sensors | grep Core
cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_label \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp2_label \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp2_input \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp3_label \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp3_input \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp4_label \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp4_input \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp5_label \
/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp5_input \
