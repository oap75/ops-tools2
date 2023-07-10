# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.5.0] 2023-07-10

### Added

- Playbook to stop blockchain docker container
- Playbook to update Ubuntu server
- Playbook to start blockchain node
- Playbook to update monitoring services
- CI to run the maintenace ansible playbooks automatically
- Playbook to get OS info
- Playbook to get Docker info
- CI to run the ServerInfo ansible playbooks automatically
- Playbook to make fresh servers ready for blockchain nodes
- CI to run the FreshServer ansible playbooks automatically
- Playbook to run the backup infra
- Playbook to destroy the backup infra
- CI to run offchain infra playbooks automatically

## [3.5.0] 2023-07-10

### Added

- Backup infra docker compose
- Backup infra nginx configs

## [3.4.0] 2023-06-29

### Added

- Staging sealed secret for grill notification
- Prod sealed secret for grill notification
- Redis for staging
- Redis for prod
- Redis staging application
- Redis prod application
- Grillchat sealed secrets for staging
- Grillchat sealed secrets for prod
- Redis staging sealed secret
- Redis prod sealed secret

## [3.3.0] 2023-06-13

### Added

- added botkube for minikube
- added runners controller
- added private runners autoscaler
- added public runners autoscaler
- added scripts to automate jobs

## [3.2.0] 2023-06-06

### Changed

- Update botkube version to 1.0.1
- Update botkube sealed secrets
- Update Loki chart

### Added

- Moderation bot sealed secrets

## [3.1.1] 2023-05-25

### Added

- Configmap for subid nginx
- Sealed secrets for subid nginx SSLs
- K8s files for subid nginx
- Added subid-nginx argocd applications

### Changed

- elastic monitoring endpoint
- elastic node exporter endpoint
- elastic cadvisor endpoint
- ipfs monitoring endoint

## [3.0.1] 2023-05-11

### Changed

- Changed staging monitoring lables and selectors
- Changed production monitoring labels and selectors

## [3.0.0] 2023-05-03

### Added

- Added staging argocd applications
- Adde production argocd applications

## [2.0.0] 2023-05-02

### Added

- Added botkube
- Added montoring (prom-stack)
- Added loki
- Added fluent-bit


## [1.3.0] 2023-05-02

### Added

- Added metrics-server

## [1.2.0] 2023-05-02

### Added

- Added nginx ingress

## [1.1.1] 2023-05-02

### Added

- Added staging moderation sealed secrets

### Changed

- Argocd sealed secrets

## [1.1.0] 2023-05-02

### Added

- Added production sealed secrets
- Added staging sealed secrets

## [1.0.1] 2023-05-02

### Changed

- Added first Readme version

## [1.0.0] 2023-05-02

### Added

- Added argocd deployment
- Added Sealed Secrets manager
