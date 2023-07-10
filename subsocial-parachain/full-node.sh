#!/bin/bash

chmod 777 -R ./data

export IS_ARCHIVE=""
[[ $1 == "archive" ]] && IS_ARCHIVE="--pruning=archive"

# Stop the corresponding parachain full node service

docker-compose -f compose-files/full-node.yml down

docker rmi dappforce/subsocial-parachain:latest

# Rerun and update the parachain full node.

docker-compose -f compose-files/full-node.yml up -d

