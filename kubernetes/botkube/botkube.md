# Botkube Stack

We have BotKube deployment to monitor the k8s events, and you should create secret named `botkube-secret` in `staging`, `prod` clusters.

## example

### 1. First, need to create a yaml file like `botkue-secret.yaml`

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: botkube-secret
  namespace: botkube
type: Opaque
stringData:
   comm_config.yaml: |
    # Communication settings
    communications:
      'default-group':
        discord:
          enabled: true
          token: '$VALUE'
          botID: '$VALUE'          
          channels:
            'default':
              id: '$VALUE'
              notification:
                disabled: false
              bindings:
                executors:
                  - kubectl-read-only
                  - helm
                sources:
                  - k8s-err-events
                  - k8s-recommendation-events
          notification:
            type: long
```

- Remember to change `$VALUE:` with the `staging` or `production` infra discord.

### 2. to create the BotKube secret in kubernetes run this command

```shell
kubectl create -f botkue-secret.yaml 
```
