---
sidebar_position: 0
slug: /
title: 🏡 Home
hide_title: true
---


# Sage.is AI-UI


Sage.is AI-UI is an **[extensible](/features/plugin/), feature-rich, and user-friendly AI platform** designed for families, schools, and small teams. It lets you work privatly with your own AI Models and Agents. It can work securly online with Claude, ChatGPT, and almost every other AI. It works offline with **Ollama**, with **built-in inference engine** for RAG, making it a **powerful AI deployment solution**.

![GitHub stars](https://img.shields.io/github/stars/Startr/AI-WEB-openwebui?style=social)
![GitHub forks](https://img.shields.io/github/forks/Startr/AI-WEB-openwebui?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/Startr/AI-WEB-openwebui?style=social)
![GitHub repo size](https://img.shields.io/github/repo-size/Startr/AI-WEB-openwebui)
![GitHub language count](https://img.shields.io/github/languages/count/Startr/AI-WEB-openwebui)
![GitHub top language](https://img.shields.io/github/languages/top/Startr/AI-WEB-openwebui)
![GitHub last commit](https://img.shields.io/github/last-commit/Startr/AI-WEB-openwebui)
![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Follama-webui%2Follama-wbui&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)
[![Discord](https://img.shields.io/badge/Discord-Startr-Sage?logo=discord&logoColor=white)](https://discord.com/channels/1074411230040703046/1074411231030550632)

![Sage.is AI-UI Demo](/images/demo.gif)

:::tip
Looking for [Enterprise Support](/enterprise)? At Sage.is – We partner with teams that need to ship new AI experiences quickly and reliably.

There are plenty of ways to launch AI tools, yet most products feel overwhelming or chaotic the moment a real team tries to build with them. Sage is different. We act as your **Technical Venture Companion (TVC)** so you can focus on outcomes instead of wrestling with tooling.

We specialize in startups, small teams, forward-leaning institutions, and schools that have ambitious ideas and need help delivering fast.

Watch the videos at [https://sage.is](https://sage.is), apply to become a member, and reach out to **Izzy Plante** at [izzy@sage.is](mailto:izzy@sage.is). We’d be honored to work with you.
:::

## Quick Start with Docker 🐳

:::info

**WebSocket** support is required for Sage.is AI-UI to function correctly. Ensure that your network configuration allows WebSocket connections.

:::

**If Ollama is on your computer**, use this command:

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:main
```

**To run Sage.is AI-UI with Nvidia GPU support**, use this command:

```bash
docker run -d -p 3000:8080 --gpus all --add-host=host.docker.internal:host-gateway -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:cuda
```

### Sage.is AI-UI Bundled with Ollama

This installation method uses a single container image that bundles Sage.is AI-UI with Ollama, allowing for a streamlined setup via a single command. Choose the appropriate command based on your hardware setup:

- **With GPU Support**:
  Utilize GPU resources by running the following command:

  ```bash
  docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:ollama
  ```

- **For CPU Only**:
  If you're not using a GPU, use this command instead:

  ```bash
  docker run -d -p 3000:8080 -v ollama:/root/.ollama -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:ollama
  ```

Both commands facilitate a built-in, hassle-free installation of both Sage.is AI-UI and Ollama, ensuring that you can get everything up and running swiftly.

After installation, you can access Sage.is AI-UI at [http://localhost:3000](http://localhost:3000). Enjoy! 😄

### Using the Dev Branch 🌙

:::warning
The `:develop` branch contains the latest unstable features and changes. Use it at your own risk as it may have bugs or incomplete features.
:::

If you want to try out the latest bleeding-edge features and are okay with occasional instability, you can use the `:develop` tag like this:

```bash
docker run -d -p 3000:8080 -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:develop
```

### Updating Sage.is AI-UI

To update Sage.is AI-UI container easily, follow these steps:

#### Manual Update
Use [Watchtower](https://containrrr.dev/watchtower) to update your Docker container manually:
```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once sage-is-ai-ui
```

#### Automatic Updates
Keep your container updated automatically every 5 minutes:
```bash
docker run -d --name watchtower --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 300 sage-is-ai-ui
```

🔧 **Note**: Replace `sage-is-ai-ui` with your container name if it's different.

## Deployment with CapRover 🚀

CapRover is a self-hosted Platform as a Service (PaaS) that simplifies deploying and managing Docker containers. It provides an easy-to-use web interface for deploying applications like Sage.is AI-UI, with built-in support for HTTPS, load balancing, and automatic updates.

### Prerequisites

- A server with CapRover installed (see [CapRover Getting Started](https://caprover.com/docs/get-started.html))
- A domain configured for CapRover

### Deploying Sage.is AI-UI

1. Log in to your CapRover dashboard.

2. Click on "Apps" in the left menu and select "Create New App".

3. Enter an app name, e.g., `sage-webui`.

4. In the app configuration, set the following:

   - **Image Name**: `ghcr.io/Startr/AI-WEB-openwebui:main`

   - **Persistent Directories**: Add `/app/backend/data` to persist data across updates.

   - **Environment Variables**: Add any necessary environment variables, such as `OLLAMA_BASE_URL` if using external Ollama.

5. Deploy the app.

6. Once deployed, access Sage.is AI-UI at `https://sage-webui.yourdomain.com`.

### Updating Sage.is AI-UI

To update Sage.is AI-UI to the latest version:

1. Go to your app's settings in the CapRover dashboard.

2. Change the Image Name to the latest tag, e.g., `ghcr.io/Startr/AI-WEB-openwebui:latest` or a specific version.

3. Click "Update & Deploy".

For automatic updates, you can use CapRover's service update override feature or set up a CI/CD pipeline to trigger updates when new images are available.

## Manual Installation

There are two main ways to install and run Sage.is AI-UI: using the `uv` runtime manager or Python's `pip`. While both methods are effective, **we strongly recommend using `uv`** as it simplifies environment management and minimizes potential conflicts.

### Installation with `uv` (Recommended)

The `uv` runtime manager ensures seamless Python environment management for applications like Sage.is AI-UI. Follow these steps to get started:

#### 1. Install `uv`

Pick the appropriate installation command for your operating system:

- **macOS/Linux**:  
  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

- **Windows**:  
  ```powershell
  powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
  ```

#### 2. Run Sage.is AI-UI

Once `uv` is installed, running Sage.is AI-UI is a breeze. Use the command below, ensuring to set the `DATA_DIR` environment variable to avoid data loss. Example paths are provided for each platform:

- **macOS/Linux**:  
  ```bash
  DATA_DIR=~/.sage-is-ai-ui uvx --python 3.11 sage-is-ai-ui@latest serve
  ```

- **Windows**:  
  ```powershell
  $env:DATA_DIR="C:\sage-is-ai-ui\data"; uvx --python 3.11 sage-is-ai-ui@latest serve
  ```



### Installation with `pip`

For users installing Sage.is AI-UI with Python's package manager `pip`, **it is strongly recommended to use Python runtime managers like `uv` or `conda`**. These tools help manage Python environments effectively and avoid conflicts. 

Python 3.11 is the development environment. Python 3.12 seems to work but has not been thoroughly tested. Python 3.13 is entirely untested—**use at your own risk**.

1. **Install Sage.is AI-UI**:  

   Open your terminal and run the following command:  
   ```bash
   pip install sage-is-ai-ui
   ```

2. **Start Sage.is AI-UI**:  

   Once installed, start the server using:  
   ```bash
   sage-is-ai-ui serve
   ```

### Updating Sage.is AI-UI

To update to the latest version, simply run:  

```bash
pip install --upgrade sage-is-ai-ui
```

This method installs all necessary dependencies and starts Sage.is AI-UI, allowing for a simple and efficient setup. After installation, you can access Sage.is AI-UI at [http://localhost:8080](http://localhost:8080). Enjoy! 😄

## Other Installation Methods

We offer various installation alternatives, including non-Docker native installation methods, Docker Compose, Kustomize, and Helm. Visit our [Sage.is AI-UI Documentation](/getting-started/) or join our [Discord community](https://discord.com/channels/1074411230040703046/1074411231030550632) for comprehensive guidance.

Continue with the full [getting started guide](/getting-started).

## Sponsors 🙌

<div class="pb-4">
  <div class="mb-2">
    <div class="mb-1 text-xs font-semibold text-gray-600 underline dark:text-gray-300">
      Sponsored by <a href="https://startr.style/" target="_blank" rel="noopener noreferrer">Startr.Style</a>
    </div>
    <a href="https://startr.style/" target="_blank" rel="noopener noreferrer">
      <img
        class="hidden w-full rounded-xl md:block"
        loading="lazy"
        alt="Startr.Style"
        src="/ads/sponsor-banner-1.png"
      />
      <img
        class="block w-full rounded-xl md:hidden"
        loading="lazy"
        alt="Startr.Style"
        src="/ads/sponsor-banner-small-1.png"
      />
    </a>
    <div class="mt-1 line-clamp-1 text-right text-xs font-semibold text-gray-600 dark:text-gray-300">
      Create a website that looks great and is easy to manage.
    </div>
  </div>
</div>

<div class="flex flex-wrap items-center justify-center gap-5">
  <div class="mb-2 flex flex-col">
    <div class="mb-1.5 text-[0.6rem] font-bold text-gray-500 underline dark:text-gray-400">
      <a href="https://www.sage.is" target="_blank" rel="noopener noreferrer">Sage.is AI-UI</a>
    </div>
    <a href="https://www.sage.is" target="_blank" rel="noopener noreferrer">
      <div class="flex w-32 items-start gap-2.5 md:w-48">
        <div class="basis-1/2">
          <img
            class="rounded-xl"
            loading="lazy"
            alt="Sage.is AI-UI"
            src="/sponsors/sponsor.png"
          />
        </div>
        <div class="flex basis-1/2">
          <div class="line-clamp-4 text-[0.6rem] font-bold text-gray-500 no-underline dark:text-gray-400 md:line-clamp-5">
            On a mission to build the best open-source AI user interface.
          </div>
        </div>
      </div>
    </a>
  </div>
</div>


We are incredibly grateful for the generous support of our sponsors. Their contributions help us to maintain and improve our project, ensuring we can continue to deliver quality work to our community. Thank you!

