#!/bin/bash 

# create namespace 
kubectl create ns botkube 

# Add botkube helm repo
helm repo add botkube https://charts.botkube.io
helm repo update
sleep 5

# create botkube secret
kubectl create -f botkube-secret.yaml

# deploy botkube 
helm install --version v1.0.1 botkube --namespace botkube --create-namespace botkube/botkube -f values.yaml
sleep 10

# verify deployment
kubectl get pods -n botkube
