---
sidebar_position: 1
title: Quick Start Guide
---

Welcome to our Quick Start Guide. We will cover running locally using Docker and also cover rapid deployment to your own personal cloud using CapRover.

## Quick Start with Docker 

### Run Sage.is AI-UI with Local AI Models

Get up and running quickly with our all-in-one container that bundles Sage.is AI-UI with Ollama for seamless local AI model management:

#### 🖥️ Standard Setup (CPU Only):

 This is perfect for testing and development environments without GPU acceleration. Make sure you have Docker installed and then open up your terminal and enter the following:

  ```bash
  docker run -d -p 3000:8080 -v ollama:/root/.ollama -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Sage-is/AI-UI:ollama
  ```

#### 🚀 Accelerated Setup (With GPU Support)

Unlock the maximum performance with GPU acceleration for faster AI responses. Again you'll need to make sure you have Docker installed and then open the terminal and enter:

  ```bash
  docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Sage-is/AI-UI:ollama
  ```

**What You Get:**

With these single commands you'll have a complete version of Sage.is AI-UI up and running locally. 

- [x] Sage.is AI-UI ready to use
- [x] Ollama pre-configured for local models
- [x] Persistent data storage
- [x] Automatic restarts
- [x] Fast and simple style and branding 
- [x] White labeling for your organization 

**Ready to Go!**  
Once running, you can access your Sage.is AI-UI at [http://localhost:3000](http://localhost:3000). Enjoy! 

### Working with Our Develop Branch

:::warning  
- [ ] **Heads up:** **For Adventurous Users Only** 

The `:develop` branch **always** contains **experimental features** still in **active development**. Expect bugs, incomplete functionality, and occasional instability. Perfect for testing and feedback, but not recommended for production use.  If you want to hack this is for you.
:::

#### ⚛ Develop Branch Setup ⚛ 

Ready to explore what's next? Use the `:develop` tag to access the latest features:

```bash
docker run -d -p 3000:8080 -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Sage-is/AI-UI:develop
```


**If Ollama is on your computer**, use this command:

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Sage-is/AI-UI:master
```

**To run Sage.is AI-UI with Nvidia GPU support**, use this command:

```bash
docker run -d -p 3000:8080 --gpus all --add-host=host.docker.internal:host-gateway -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Sage-is/AI-UI:cuda
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

   - **Image Name**: `ghcr.io/Sage-is/AI-UI:master`

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

2. On the Deployment tab, change the Image Name under **Method 6: Deploy via ImageName** to the latest tag, e.g., `ghcr.io/Sage-is/AI-UI:latest` or a specific version.

3. Click **Deploy Now**.


:::info **Important Note on User Roles and Privacy:**

- **Admin Creation:** The first account created on Sage.is AI-UI gains **Administrator Privileges**, allowing control of user management and system settings.
- **User Registrations:** Subsequent sign-ups start with **Pending** status, requiring Administrator approval for access.
- **Privacy and Data Security:** **All your data**, including login details, is **locally stored** on your device. Sage.is AI-UI ensures **strict confidentiality** and **no external requests** for enhanced privacy and security.
- **All models are private by default.** New AI models must be explicitly shared via groups or by made public. If a model is assigned to a group, only members of that group can see it. If a model is set as public, anyone on logged into your Sage.is AI-UI server can see it.

:::

