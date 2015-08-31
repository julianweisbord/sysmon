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


#get rid of some info in lscpu
lscpu
#get model name
for line in $(grep -Fm 1 "$model name" /proc/cpuinfo)
do
 printf "$line " 
done
printf "\n"

