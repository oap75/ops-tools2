#!/bin/bash 

packer build -var-file=variables.json template.json
