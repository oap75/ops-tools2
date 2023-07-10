#!/bin/bash 

read -p "Enter GH token: " PAT

kubectl create secret generic gh-pat-secret  --namespace=arc-systems  --from-literal=github_token=$PAT

kubectl create secret generic gh-pat-secret  --namespace=arc-public-runners  --from-literal=github_token=$PAT

kubectl create secret generic gh-pat-secret  --namespace=arc-private-runners  --from-literal=github_token=$PAT
