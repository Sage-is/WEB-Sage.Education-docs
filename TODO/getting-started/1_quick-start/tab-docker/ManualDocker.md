## Quick Start with Docker 🐳

Follow these steps to install Sage.is AI-UI with Docker.

## Step 1: Pull the Sage.is AI-UI Image

Start by pulling the latest Sage.is AI-UI Docker image from the GitHub Container Registry.

```bash
docker pull ghcr.io/Sage-is/AI-UI:master
```

## Step 2: Run the Container

Run the container with default settings. This command includes a volume mapping to ensure persistent data storage.

```bash
docker run -d -p 3000:8080 -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui ghcr.io/Sage-is/AI-UI:master
```

### Important Flags

- **Volume Mapping (`-v sage-is-ai-ui:/app/backend/data`)**: Ensures persistent storage of your data. This prevents data loss between container restarts.
- **Port Mapping (`-p 3000:8080`)**: Exposes the Sage.is AI-UI on port 3000 of your local machine.

### Using GPU Support

For Nvidia GPU support, add `--gpus all` to the `docker run` command:

```bash
docker run -d -p 3000:8080 --gpus all -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui ghcr.io/Sage-is/AI-UI:cuda
```


#### Single-User Mode (Disabling Login)

To bypass the login page for a single-user setup, set the `Sage.is AI-UI_AUTH` environment variable to `False`:

```bash
docker run -d -p 3000:8080 -e Sage.is AI-UI_AUTH=False -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui ghcr.io/Sage-is/AI-UI:master
```

:::warning
You cannot switch between single-user mode and multi-account mode after this change.
:::

#### Advanced Configuration: Connecting to Ollama on a Different Server

To connect Sage.is AI-UI to an Ollama server located on another host, add the `OLLAMA_BASE_URL` environment variable:

```bash
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=https://example.com -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Sage-is/AI-UI:master
```

## Access the Sage.is AI-UI

After the container is running, access Sage.is AI-UI at:

[http://localhost:3000](http://localhost:3000)

For detailed help on each Docker flag, see [Docker's documentation](https://docs.docker.com/engine/reference/commandline/run/).
