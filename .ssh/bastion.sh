#!/usr/bin/env bash
# direct copy from dusty - https://github.corp.clover.com/dusty-gutzmann/dotfiles/blob/master/.ssh/bastion.sh

# echo the host dns entry, cut based on dot (.) pick up the third element which is the dataCenter
dataCenter=$(echo $1 | cut -d. -f3)
availableBastionHosts=$(grep ${dataCenter} ~/.ssh/bastions.txt)
randomBastionHost=${availableBastionHosts[$RANDOM % ${#availableBastionHosts[@]}]}

#>&2  echo "${2:+-W $1:$2} -A $onehost"
ssh ${2:+-W $1:$2} $randomBastionHost
