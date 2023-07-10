#!/bin/bash

# Stop the corresponding parachain collator service

docker-compose -f rpc-compose.yaml down -v

docker rmi dappforce/subsocial-node:latest

# Configure volumes

mkdir -p data
chmod 777 -R data

# Boot up RPC node

docker-compose -f rpc-compose.yaml up -d
