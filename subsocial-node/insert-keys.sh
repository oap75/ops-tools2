#!/bin/bash

# Get a key from validarot-key-mnemonic file
SECRET_SEED=$(cat validator-key-mnemonic)

# Insert aura key into the validator node
docker exec -i subsocial-validator \
  subsocial-node key insert --base-path=/data --chain=df --scheme=sr25519 --suri $SECRET_SEED --key-type aura

# Insert grandpa key into the validator node
docker exec -i subsocial-validator \
  subsocial-node key insert --base-path=/data --chain=df --scheme=ed25519 --suri $SECRET_SEED --key-type gran
