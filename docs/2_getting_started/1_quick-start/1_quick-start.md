---
sidebar_position: 1
title: Quick Start Guide
---

Welcome to our Quick Start Guide. We will cover running Sage.is AI-UI on your own computer and also cover rapid deployment to your own personal cloud using CapRover.

## Quick Start on a Mac

### Run Sage.is AI-UI with Homebrew

The `ai-ui` command runs Sage.is AI-UI in [Colima](https://github.com/abiosoft/colima), a free container runtime with no window and no sign-in. Homebrew installs Colima and [Ollama](https://ollama.com) with it.

1. **Apple Silicon only:** install krunkit first. `ai-ui` then gives Colima a krunkit VM: memory the VM frees goes back to macOS, and containers can reach the GPU. Without krunkit, `ai-ui` uses a standard Colima VM. Skip this step on an Intel Mac.

   ```bash
   brew tap libkrun/krun && brew trust libkrun/krun && brew install krunkit
   ```

   `ai-ui version` shows your release. If it ends in `(server 3.2.0)`, `ai-ui` never makes a krunkit VM, even with krunkit installed. Later releases do, and `ai-ui migrate` converts a standard VM. The first line of `colima status` names the VM.

2. Install `ai-ui` and start Sage.is AI-UI. It runs at [http://localhost:8080](http://localhost:8080), and `ai-ui open` opens it in your browser.

   ```bash
   brew install sage-is/apps/ai-ui && ai-ui start
   ```

3. For local models, start Ollama. Sage.is AI-UI finds it at `host.docker.internal:11434`.

   ```bash
   brew services start ollama
   ```

Already use Docker Desktop or OrbStack? `ai-ui` supports both and remembers your choice: `ai-ui start --runtime docker-desktop` or `ai-ui start --runtime orbstack`.

## Quick Start with Docker on Linux and Windows

### 🖥️ Run Sage.is AI-UI with Docker

Install [Docker Engine](https://docs.docker.com/engine/install/) on Linux, or Docker Desktop on Windows. Then open your terminal and enter the following:

```bash
docker run -d -p 8080:8080 --add-host=host.docker.internal:host-gateway -v sage-ai-data:/app/backend/data --name sage-ai --restart always ghcr.io/sage-is/ai-ui:latest
```

`--add-host` lets the container reach services on your computer, such as Ollama, at `host.docker.internal`. Docker Engine on Linux needs it. Docker Desktop resolves the name on its own, and the flag does no harm there.

Image names are lowercase: Docker rejects `ghcr.io/Sage-is/AI-UI`. The `latest` tag follows each release. To pin a version, use its tag instead, such as `ghcr.io/sage-is/ai-ui:3.2.0`.

#### 🚀 GPU Acceleration

The image does not bundle Ollama, and Sage.is AI-UI itself runs well on the CPU. Your GPU speeds up the models, so run [Ollama](https://ollama.com) directly on your computer, where it uses the GPU. If the container cannot reach it, see [Connection Troubleshooting](../../3_troubleshooting/connection-error.md).

## What You Get

With these commands you'll have a complete version of Sage.is AI-UI up and running locally.

- [x] Sage.is AI-UI ready to use
- [x] Ollama connection for local models
- [x] Persistent data storage
- [x] Fast and simple style and branding
- [x] White labeling for your organization

**Ready to Go!**  
Once running, you can access your Sage.is AI-UI at [http://localhost:8080](http://localhost:8080). Enjoy!

## Working with Our Develop Branch

:::warning

- [ ] **Heads up:** **For Adventurous Users Only**

The `develop` branch **always** contains **experimental features** still in **active development**. Expect bugs, incomplete functionality, and occasional instability. Perfect for testing and feedback, but not recommended for production use.  If you want to hack this is for you.
:::

### ⚛ Develop Branch Setup ⚛

Ready to explore what's next? We publish images for releases only, so run the `develop` branch from source. You need the `ai-ui` command, which runs on macOS and Linux: `brew install sage-is/apps/ai-ui`.

```bash
ai-ui dev
```

`ai-ui dev` clones the [AI-UI source](https://github.com/Sage-is/AI-UI), which opens on the `develop` branch, into `~/src/ai-ui` and starts it in dev mode. `ai-ui dev --where` shows where your copy lives.

`ai-ui dev` replaces your running Sage.is AI-UI, and `ai-ui start` brings the release back. Both use the same `sage-ai-data` volume. Develop can upgrade your database past what the release reads, and `ai-ui start` then fails. Back up your data before you run `ai-ui dev`.

On a Mac, `docker` in your terminal follows the runtime that started last, which may not be the one `ai-ui` uses. `cat ~/.sage-is/runtime` names that one. Point `docker` at it first: `export DOCKER_CONTEXT=colima`, or `desktop-linux` for Docker Desktop, or `orbstack` for OrbStack. Skip this step on Linux, or if the file does not exist.

This command stops Sage.is AI-UI and saves its data to `~/sage-ai-data.tgz`. It stops early if the volume is missing:

```bash
ai-ui stop && docker volume inspect sage-ai-data >/dev/null && docker run --rm -v sage-ai-data:/data:ro -v "$HOME":/backup alpine tar -czf /backup/sage-ai-data.tgz -C /data .
```

To go back to the release, restore the backup and start it. The restore reads the whole archive before it clears the volume:

```bash
ai-ui stop && docker run --rm -v sage-ai-data:/data -v "$HOME":/backup alpine sh -c 'tar -tzf /backup/sage-ai-data.tgz >/dev/null && find /data -mindepth 1 -delete && tar -xzf /backup/sage-ai-data.tgz -C /data' && ai-ui start
```

If `ai-ui version` does not end in `(server 3.2.0)`, you can give develop its own volume instead. The release keeps `sage-ai-data` to itself:

```bash
SAGE_AI_VOLUME=sage-ai-dev ai-ui dev
```

:::info

**WebSocket** support is required for Sage.is AI-UI to function correctly. Ensure that your network configuration allows WebSocket connections.

:::

## Deployment with CapRover 🚀

CapRover is a self-hosted Platform as a Service (PaaS) that simplifies deploying and managing Docker containers to your personal cloud. It provides an easy-to-use web interface for deploying applications like Sage.is AI-UI, with built-in support for HTTPS, load balancing, and automatic updates.

### Prerequisites

- A server with CapRover installed (see [CapRover Getting Started](https://caprover.com/docs/get-started.html))
- A [domain configured](https://caprover.com/docs/get-started.html#a-domain-name) for CapRover.

### Deploying Sage.is AI-UI

1. Log in to your CapRover dashboard.

2. Click on "Apps" in the left menu and select "Create New App".

3. Enter an app name, e.g., `sage-is-ai-ui`.

4. In the app configuration, set the following:

   - **Image Name**: `ghcr.io/sage-is/ai-ui:latest`

   - **Container HTTP Port** (HTTP Settings tab): `8080`

   - **Persistent Directories**: Add `/app/backend/data` to persist data across updates.

   - **Environment Variables**: Add any necessary environment variables, such as `OLLAMA_BASE_URL` if using external Ollama.

5. Deploy the app.

6. Once deployed, access Sage.is AI-UI at `https://sage-is-ai-ui.yourcaprover.yourdomain.com`.

:::note

Follow the documentation and setup of CapRover at [CapRover Getting Started](https://caprover.com/docs/get-started.html) and  use your CapRover subdomain and your domain, and not: `yourcaprover.yourdomain.com`. We don't know your actual domain names.

:::

### Updating Sage.is AI-UI

To update Sage.is AI-UI to the latest version or a specific version:

1. Go to your app's settings in the CapRover dashboard.

2. On the Deployment tab, change the Image Name under **Method 6: Deploy via ImageName** to the latest tag, e.g., `ghcr.io/sage-is/ai-ui:latest` or a specific version such as `ghcr.io/sage-is/ai-ui:3.2.0`.

3. Click **Deploy Now**.

:::info **Important Note on User Roles and Privacy:**

- **Admin Creation:** The first account created on Sage.is AI-UI gains **Administrator Privileges**, allowing control of user management and system settings.
- **User Registrations:** Subsequent sign-ups start with **Pending** status, requiring Administrator approval for access.
- **Privacy and Data Security:** **All your data**, including login details, is **locally stored** on your device. Sage.is AI-UI ensures **strict confidentiality** and **no external requests** for enhanced privacy and security.
- **All models are private by default.** New AI models must be explicitly shared via groups or by made public. If a model is assigned to a group, only members of that group can see it. If a model is set as public, anyone on logged into your Sage.is AI-UI server can see it.

:::

