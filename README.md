# hello-ping

Minimal Go HTTP service exposing `GET /ping` → `pong` (listens on `:8080`, override with `PORT`).

It exists to demonstrate **keyless** Harbor workflow identity federation end to end:

- **Push without secrets:** the `build-push` GitHub Action mints a GitHub OIDC token
  (`id-token: write`) and uses it as the Docker password (`docker login c8n.io -u jwt`).
  Harbor's federated identity provider validates the token and maps the `repository` claim
  to a push robot. No registry credentials are stored in the repo.
- **Pull without secrets:** on the target Kubernetes cluster, the
  [harbor-workload-identity-federation](https://github.com/container-registry/harbor-workload-identity-federation)
  kubelet credential provider hands the pod's ServiceAccount token to Harbor, which maps the
  `sub` claim to a pull robot. The Deployment carries no `imagePullSecrets`.

Image: `c8n.io/vad1mo-github/hello-ping`.

## Run locally

```sh
go run .
curl localhost:8080/ping   # -> pong
```
