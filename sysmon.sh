#!/bin/bash
#user might have to be root for some of these commands
set -e


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
printf "Host on: $(uname -a)\n\n"

printf "CPU Information:\n"
# #get rid of some info in lscpu
# lscpu
#get model name
for line in $(grep -Fm 1 "$model name" /proc/cpuinfo)
do
 printf "$line "
done
printf "\n"
#gives number of cpus
printf "Total "
grep -i "cpu cores" /proc/cpuinfo | sort -u
lscpu | grep -i "Thread(s) per core:" | sort -u
lscpu | grep -i "Architecture:\|CPU family:\|Core(s) per socket:\|CPU MHz\|L1d cache:\|L1i cache:\|L2 cache:\|L3 cache:" | sort -u
# printf "Turbo Boost"
#
# # printf "Total Frequency: "

for line in $(sudo lshw | grep -i "$cpu capacity" | sort -u)
do
  printf $line | grep -iT "MHz" | sort -u
done
