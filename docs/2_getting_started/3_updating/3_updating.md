---
sidebar_position: 300
title: Update Sage.is AI-UI
---
To update your local Docker installation of Sage.is AI-UI to the latest version available, you can either use **Watchtower** or manually update the container. Follow either of the steps provided below to be guided through updating your existing Sage.is AI-UI.

### Manual Update

1. **Stop and remove the current container**:

   This will stop the running container and remove it, but it won't delete the data stored in the Docker volume. (Replace `sage-is-ai-ui` with your container's name throughout the updating process if it's different for you.)

```bash
docker rm -f sage-is-ai-ui
```

2. **Pull the latest Docker image**:

   This will update the Docker image, but it won't update a running container or its data.

```bash
docker pull ghcr.io/Sage-is/AI-UI:master
```


:::info
**Remove any existing data in the Docker volume (NOT RECOMMENDED UNLESS ABSOLUTELY NECCESSARY!)**. Skip this step entirely if not needed and move on to the last step:

   If you want to start with a clean slate, you can remove the existing data in the Docker volume. Be careful, as this will delete all your chat histories and other data.

   The data is stored in a Docker volume named `sage-is-ai-ui`. You can remove it with the following command:

```bash
docker volume rm sage-is-ai-ui
```
:::

3. **Start the container again with the updated image and existing volume attached**:

   If you didn't remove the existing data, this will start the container with the updated image and the existing data. If you removed the existing data, this will start the container with the updated image and a new, empty volume. 
   
```bash
docker run -d -p 3000:8080 -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui ghcr.io/Sage-is/AI-UI:master
```

:::note
 If you have an Nvidia GPU, remember to add `--gpus all` to the docker run command as we did in the [GPU Setup](/getting_started/quick-start/#-accelerated-setup-with-gpu-support) in the Quick Start Guide.
:::
## Automatically Updating Sage.is AI-UI with Watchtower

You can use [Watchtower](https://containrrr.dev/watchtower/) to simplify and automate the update process for Sage.is AI-UI. Watchtower will pull down the latest Sage.is AI-UI Docker image, gracefully shut down your existing container and restart it with the same options that were used when you deployed it. 

You can do this either as a one-time update or keep Watchtower up in a separate container and allow it to update Sage.is AI-UI at regular intervals as we release official updates.

### One-time Update with Watchtower

You can run Watchtower as a one-time update. The following command will stop the current container, pull the latest image, and start a new container with the updated image and existing volume attached:

```bash
docker run --rm --name watchtower \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower --run-once sage-is-ai-ui
```

This command starts Watchtower, checks for the latest updates, applies it if there is one, and brings Watchtower down.
### Let Watchtower Update When Updates are Available

If you would like to automate this process and allow Watchtower to check for new releases at regular intervals, you can run Watchtower as a separate container that watches and updates your Sage.is AI-UI container:

```bash
docker run -d --name watchtower \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower -i 300 sage-is-ai-ui
```


This command starts Watchtower in detached mode, watching your Sage.is AI-UI container for updates every 300 seconds (5 minutes).


