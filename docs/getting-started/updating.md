---
sidebar_position: 300 
title: "🔄 Updating Sage.is AI-UI"
---



## Why isn't my Sage.is AI-UI updating?

To update your local Docker installation of Sage.is AI-UI to the latest version available, you can either use **Watchtower** or manually update the container. Follow either of the steps provided below to be guided through updating your existing Sage.is AI-UI image.

### Manual Update

1. **Stop and remove the current container**:

   This will stop the running container and remove it, but it won't delete the data stored in the Docker volume. (Replace `sage-is-ai-ui` with your container's name throughout the updating process if it's different for you.)

```bash
docker rm -f sage-is-ai-ui
```

2. **Pull the latest Docker image**:

   This will update the Docker image, but it won't update the running container or its data.

```bash
docker pull ghcr.io/Startr/AI-WEB-openwebui:main
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

   If you didn't remove the existing data, this will start the container with the updated image and the existing data. If you removed the existing data, this will start the container with the updated image and a new, empty volume. **For Nvidia GPU support, add `--gpus all` to the docker run command**

```bash
docker run -d -p 3000:8080 -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui ghcr.io/Startr/AI-WEB-openwebui:main
```

## Automatically Updating Sage.is AI-UI with Watchtower

You can use [Watchtower](https://containrrr.dev/watchtower/) to automate the update process for Sage.is AI-UI. Here are three options:

### Option 1: One-time Update

You can run Watchtower as a one-time update to stop the current container, pull the latest image, and start a new container with the updated image and existing volume attached (**For Nvidia GPU support, add `--gpus all` to the docker run command**):

```bash
docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once sage-is-ai-ui
```

### Option 2: Running Watchtower as a Separate Container

You can run Watchtower as a separate container that watches and updates your Sage.is AI-UI container:

```bash
docker run -d --name watchtower \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower -i 300 sage-is-ai-ui
```

This will start Watchtower in detached mode, watching your Sage.is AI-UI container for updates every 5 minutes.

### Option 3: Integrating Watchtower with a `docker-compose.yml` File

You can also integrate Watchtower with your `docker-compose.yml` file to automate updates for Sage.is AI-UI (**For Nvidia GPU support, add `--gpus all` to the docker run command**):

```yml
version: '3'
services:
  sage-is-ai-ui:
    image: ghcr.io/Startr/AI-WEB-openwebui:main
    ports:
      - "3000:8080"
    volumes:
      - sage-is-ai-ui:/app/backend/data

  watchtower:
    image: containrrr/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --interval 300 sage-is-ai-ui
    depends_on:
      - sage-is-ai-ui

volumes:
  sage-is-ai-ui:
```

In this example, Watchtower is integrated with the `docker-compose.yml` file and watches the Sage.is AI-UI container for updates every 5 minutes.

## Persistent Data in Docker Volumes

The data is stored in a Docker volume named `sage-is-ai-ui`. The path to the volume is not directly accessible, but you can inspect the volume with the following command:

```bash
docker volume inspect sage-is-ai-ui
```

This will show you the details of the volume, including the mountpoint, which is usually located in `/var/lib/docker/volumes/sage-is-ai-ui/_data`.  

On Windows 10 + WSL 2, Docker volumes are located here (type in the Windows file explorer): 
- \\\wsl$\docker-desktop\mnt\docker-desktop-disk\data\docker\volumes

For older versions of Docker (pre-Docker v26.1.4):
- \\\wsl$\docker-desktop-data\data\docker\volumes
- \\\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes

_(Windows answer credit to StackOverflow user sarye-haddadi; [link to original SO post](https://stackoverflow.com/questions/43181654/locating-data-volumes-in-docker-desktop-windows))_
