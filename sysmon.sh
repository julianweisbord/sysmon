#!/bin/bash

set -e

bold=$(tput bold)
normal=$(tput sgr0)
if [ $USER != "root" ]
then
  echo "Make sure you are root."
  exit 1
fi

if [[ "$1" = "-a" ]]
  then
  DISK="$(sudo lshw -short | grep 'disk\|volume')"
  GPU="$(sudo lshw -C display | grep 'clock')"
fi

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
# GPU
printf "GPU Information:\n"
printf "================\n"
# lspci -vnn | grep VGA -A 12
lspci | grep -i "VGA"
printf "$GPU\n"
#There is some gpu information at /devices/pci0000:00/0000:00:02.0/graphics/

# motherboard
printf "\nMotherboard Information:\n"
printf "========================\n"
sudo dmidecode -t 2 | grep -i "Manufacturer\|Product Name"
sudo dmidecode -t 4 | grep -i "Socket"

printf "\nTemperatures °C: \n"
printf "=============\n"
all_hw=(1 2 3 4 5)
all_temp=(_label _input)
input_path=/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp
for num in ${all_hw[*]};
  do
    label=""
    output=""
    for type in ${all_temp[*]};
      do
        file=${input_path}${num}${type}
        while IFS='' read -r line || [[ -n "$line" ]];
          do
            if [[ ${type} == ${all_temp[0]} ]];
              then
                label=$line
            fi
            if [[ ${type} == ${all_temp[1]} ]];
              then
                output=$line
            fi
        done < ${file}
    done;
    length=${#output}-3
    echo -e "$label\t${output:0:$length}°"

done;
