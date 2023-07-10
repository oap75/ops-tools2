#!/bin/bash

helm install public-runners \
    --namespace "arc-public-runners" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set -f values.yaml


sleep 10


kubectl get pods -n arc-public-runner
