# obby-helm

Helm chart for deploying the [Obby](https://github.com/ObsidianIRC) stack
on Kubernetes. The Docker Compose equivalent lives in
[obby-stack](https://github.com/ObsidianIRC/obby-stack).

This repo ships **one chart** (`obby/`) that deploys all three services
(`obbyircd`, `obby-api`, `obby` web) with shared config and a single
ingress.

## Quick install

```bash
helm repo add obby oci://ghcr.io/ObsidianIRC/charts
helm install obby obby/obby \
  --namespace obby --create-namespace \
  --set global.ircFqdn=irc.example.com \
  --set global.apiFqdn=api.example.com \
  --set global.webFqdn=chat.example.com \
  --set obbyircd.cloakKey1=$(openssl rand -hex 48) \
  --set obbyircd.cloakKey2=$(openssl rand -hex 48) \
  --set obbyircd.cloakKey3=$(openssl rand -hex 48) \
  --set obbyApi.jwtSecret=$(openssl rand -hex 32) \
  --set obbyApi.turnSecret=$(openssl rand -hex 32)
```

Or copy `obby/values.example.yaml` to a local file and pass with `-f`.

## Layout

```
obby/
├── Chart.yaml
├── values.yaml             # defaults
├── values.example.yaml     # annotated production-shaped example
└── templates/
    ├── _helpers.tpl
    ├── NOTES.txt
    ├── obbyircd-statefulset.yaml
    ├── obbyircd-pvc.yaml
    ├── obbyircd-service.yaml
    ├── obby-api-deployment.yaml
    ├── obby-api-pvc.yaml
    ├── obby-api-service.yaml
    ├── obby-web-deployment.yaml
    ├── obby-web-service.yaml
    ├── ingress.yaml
    └── secrets.yaml
```

## Status

Early skeleton. Templates render but have not been exercised against a
live cluster yet. Bugs welcome.

## Disabling the web frontend

```yaml
obbyWeb:
  enabled: false
```
