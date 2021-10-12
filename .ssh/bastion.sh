#!/usr/bin/env bash
# direct copy from dusty - https://github.corp.clover.com/dusty-gutzmann/dotfiles/blob/master/.ssh/bastion.sh

dc=$(echo $1 | cut -d. -f3)
hosts=$(grep ${dc} ~/.ssh/bastions.txt)
onehost=${hosts[$RANDOM % ${#hosts[@]}]}

#>&2  echo "${2:+-W $1:$2} -A $onehost"
ssh ${2:+-W $1:$2} $onehost
