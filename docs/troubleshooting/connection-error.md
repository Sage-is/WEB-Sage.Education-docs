---
sidebar_position: 0
title: "🚧 Server Connectivity Issues"
---

We're here to help you get everything set up and running smoothly. Below, you'll find step-by-step instructions tailored for different scenarios to solve common connection issues with Ollama and external servers like Hugging Face.

## 🌟 Connection to Ollama Server

### 🚀 Accessing Ollama from Sage.is AI-UI

Struggling to connect to Ollama from Sage.is AI-UI? It could be because Ollama isn’t listening on a network interface that allows external connections. Let’s sort that out:

1. **Configure Ollama to Listen Broadly** 🎧:
   Set `OLLAMA_HOST` to `0.0.0.0` to make Ollama listen on all network interfaces.

2. **Update Environment Variables**:
   Ensure that the `OLLAMA_HOST` is accurately set within your deployment environment.

3. **Restart Ollama**🔄:
   A restart is needed for the changes to take effect.

💡 After setting up, verify that Ollama is accessible by visiting the WebUI interface.

For more detailed instructions on configuring Ollama, please refer to the [Ollama's Official Documentation](https://github.com/ollama/ollama/blob/main/docs/faq.md#setting-environment-variables-on-linux).

### 🐳 Docker Connection Error

If you're seeing a connection error when trying to access Ollama, it might be because the WebUI docker container can't talk to the Ollama server running on your host. Let’s fix that:

1. **Adjust the Network Settings** 🛠️:
   Use the `--network=host` flag in your Docker command. This links your container directly to your host’s network.

2. **Change the Port**:
   Remember that the internal port changes from 3000 to 8080.

**Example Docker Command**:
```bash
docker run -d --network=host -v sage-is-ai-ui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:main
```
🔗 After running the above, your WebUI should be available at `http://localhost:8080`.

## 🔒 SSL Connection Issue with Hugging Face

Encountered an SSL error? It could be an issue with the Hugging Face server. Here's what to do:

1. **Check Hugging Face Server Status**:
   Verify if there's a known outage or issue on their end.

2. **Switch Endpoint**:
   If Hugging Face is down, switch the endpoint in your Docker command.

**Example Docker Command for Connected Issues**:
```bash
docker run -d -p 3000:8080 -e HF_ENDPOINT=https://hf-mirror.com/ --add-host=host.docker.internal:host-gateway -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:main
```

## 🍏 Podman on MacOS

Running on MacOS with Podman? Here’s how to ensure connectivity:

1. **Enable Host Loopback**:
   Use `--network slirp4netns:allow_host_loopback=true` in your command.

2. **Set OLLAMA_BASE_URL**:
   Ensure it points to `http://host.containers.internal:11434`.

**Example Podman Command**:
```bash
podman run -d --network slirp4netns:allow_host_loopback=true -p 3000:8080 -e OLLAMA_BASE_URL=http://host.containers.internal:11434 -v sage-is-ai-ui:/app/backend/data --name sage-is-ai-ui --restart always ghcr.io/Startr/AI-WEB-openwebui:main
```

