#!/bin/bash

helm install private-runners \
    --namespace "arc-private-runners" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set -f values.yaml

sleep 10


kubectl get pods -n arc-private-runners
