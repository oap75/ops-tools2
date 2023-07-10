#!/bin/bash

RED='\033[0;31m'
CY='\033[0;36m'
GR='\033[0;32m'
YEL='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${CY}"
helm install arc     --namespace "arc-systems"     --create-namespace     oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller -f values.yaml

sleep 7 

echo -e "${GR}"
kubectl get pods -n arc-systems

sleep 15 

first_pod=$(kubectl get pods -n arc-systems | sed 's/|/ /' | awk '{print $1}' | sed -n 2p)

second_pod=$(kubectl get pods -n arc-systems | sed 's/|/ /' | awk '{print $1}' | sed -n 3p)

if kubectl -n arc-systems logs $first_pod | grep successfully ; then 
	echo -e "${YEL}get the logs of ${RED}$first_pod" ${NC}
	kubectl -n arc-systems logs $first_pod
else
        echo -e "${YEL}get the logs of ${RED}$second_pod" ${NC}
        kubectl -n arc-systems logs $second_pod   
fi
