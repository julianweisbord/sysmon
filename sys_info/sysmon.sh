#!/bin/bash
#user might have to be root for some of these commands
set -e

#add epoch time


i=0
printf "\ndate: "
for out in $(date)
do
  i=$((i+1))
  printf "$out "
  if [[ $i == 4 ]]
  then
    break
  fi
done
printf "\n\n\n"


#get rid of some info in lscpu
lscpu

grep -F "$model name" /proc/cpuinfo echo $model
# for line in "/proc/cpuinfo"
#do
#   if[[ grep -q $line model ]]
#   then
#       printf $line
#   fi
# done

# while read f
# do
#   if [[ ]]
#   echo $f
#   # for name in $f
#   # do
#   #   # if grep -q "$model"
#   #   # then
#   #       echo $f
#   #   # fi
#   # done
# done </proc/cpuinfo
