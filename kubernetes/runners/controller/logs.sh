#!/bin/bash 

RED='\033[0;31m'
YEL='\033[1;33m'
NC='\033[0m' # No Color

first_pod=$(kubectl get pods -n arc-systems | sed 's/|/ /' | awk '{print $1}' | sed -n 2p)

second_pod=$(kubectl get pods -n arc-systems | sed 's/|/ /' | awk '{print $1}' | sed -n 3p)

if kubectl -n arc-systems logs $first_pod | grep successfully ; then
	echo -e "${YEL}get the logs of ${RED}$first_pod" ${NC}
	kubectl -n arc-systems logs -f $first_pod
else
        echo -e "${YEL}get the logs of ${RED}$second_pod" ${NC}
        kubectl -n arc-systems logs -f $second_pod
fi
