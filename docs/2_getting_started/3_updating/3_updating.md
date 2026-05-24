---
sidebar_position: 300
title: Update Sage.is AI-UI
---

When the in-app banner says a new version is available, the path you take depends on how you deployed.

## CapRover deployments (production / `try.sage.is`-style)

CapRover can pull new tags from GHCR automatically. Every Sage.is release pushes its tag to GHCR only after passing the release smoke gate, so auto-deploying `:latest` is structurally safe.

To verify or enable auto-update:

1. Open your app in the CapRover dashboard.
2. Confirm the **App Configurations** image is `ghcr.io/sage-is/ai-ui:latest` (or a tag you intend to pin).
3. To redeploy now, click **Force Build** on the same image. To redeploy on every new GHCR tag, configure a webhook or polling trigger — see [CapRover's app configuration docs](https://caprover.com/docs/app-configuration.html).

## Homebrew / `ai-ui` CLI (Mac and Linux)

If you installed via the `sage-is/apps` Homebrew tap:

```bash
ai-ui update --tag X.Y.Z
```

Replace `X.Y.Z` with the version shown in the banner. The data volume is preserved.

## Manual Docker

Stop the container, pull, restart with the same volume:

```bash
docker rm -f sage-ai
docker pull ghcr.io/sage-is/ai-ui:X.Y.Z
docker run -d -p 8080:8080 -v sage-ai-data:/app/backend/data \
  --name sage-ai ghcr.io/sage-is/ai-ui:X.Y.Z
```

The volume `sage-ai-data` preserves your chats, knowledge bases, and downloaded models. The container is disposable; the volume is not.

:::info
**Removing the data volume erases everything.** Don't run `docker volume rm sage-ai-data` unless you intend a clean start. The container can be removed safely; the volume holds your data.
:::

:::note
If you have an Nvidia GPU and use the CUDA image variant, remember to add `--gpus all` to the `docker run` command.
:::

## Portainer / Kubernetes / other orchestrators

Configure your orchestrator to pull `ghcr.io/sage-is/ai-ui:<tag>` on the schedule that fits your operations. Most orchestrators have webhook-based or label-based auto-deploy mechanisms similar to CapRover's.

## Watchtower (auto-update sidecar)

The original `containrrr/watchtower` was archived in December 2025. The maintained fork is [`nicholas-fedor/watchtower`](https://github.com/nicholas-fedor/watchtower).

```bash
docker run -d --name watchtower \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  nickfedor/watchtower -i 300 sage-ai
```

This polls for new images every 300 seconds and recreates the `sage-ai` container when one arrives.

:::caution
**Watchtower has no rollback.** If a new image fails to start, the old container is already removed. The Sage.is release smoke gate makes this rare, but if you need rollback-on-failure, prefer CapRover or another orchestrator with health-check-aware deploys.
:::

## Need help?

Reach out: [support@sage.is](mailto:support@sage.is)
