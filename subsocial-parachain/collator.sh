#!/bin/bash

chmod 777 -R ./data

# Stop the corresponding parachain collator service

docker-compose -f compose-files/collator.yml down

docker rmi dappforce/subsocial-parachain:latest

# Rerun and update the parachain collator.

docker-compose -f compose-files/collator.yml up -d

