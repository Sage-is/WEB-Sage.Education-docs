---
sidebar_position: 0
title: Connection Troubleshooting
---

## Connection to Ollama Server

### Accessing Ollama from Sage.is AI-UI

Struggling to connect to Ollama from Sage.is AI-UI? It could be because your Ollama instance isn’t listening on a network interface that allows external connections. Let’s sort that out:

1. **Configure Ollama to Listen Broadly**:
   Set `OLLAMA_HOST` to `0.0.0.0` to make Ollama listen on all network interfaces.

2. **Update Environment Variables**:
   Ensure that the `OLLAMA_HOST` is accurately set within your deployment environment.

3. **Restart Ollama**:
   A restart is needed for the changes to take effect.

 After setting up, verify that Ollama is accessible by visiting the Sage.is AI-UI interface.

For more detailed instructions on configuring Ollama, please refer to the [Ollama's Official Documentation](https://github.com/ollama/ollama/blob/main/docs/faq.md#setting-environment-variables-on-linux).

###  Docker Connection Error

If you're seeing a connection error when trying to access Ollama, it might be because the Sage.is AI-UI docker container can't talk to the Ollama server running on your host. Let’s fix that:

1. **Map the Host Name** 🛠️:
   Add `--add-host=host.docker.internal:host-gateway` to your Docker command. Inside the container, `host.docker.internal` then means your computer. Docker Engine on Linux needs the flag; Colima, Docker Desktop and OrbStack resolve the name on their own and honor the flag too.

2. **Point Sage.is AI-UI at Ollama**:
   Set `OLLAMA_BASE_URL=http://host.docker.internal:11434`. This is already the image's default.

**Example Docker Command**:
```bash
docker run -d --name sage-ai -p 8080:8080 \
	--add-host=host.docker.internal:host-gateway \
	-v sage-ai-data:/app/backend/data \
	-e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
	--restart always ghcr.io/sage-is/ai-ui:latest
```
🔗 After running the above, your Sage.is AI-UI should be available at `http://localhost:8080`.

On Linux, Ollama listens only on `127.0.0.1` by default, so the container still cannot reach it. Set `OLLAMA_HOST` to `0.0.0.0` as described above.

### Host Network (Linux Only)

On Linux, the `--network=host` flag also works. It links your container directly to your host’s network, so `127.0.0.1` reaches Ollama and the app listens on port 8080. On a Mac or Windows, Docker runs inside a VM, so the host network is the VM's network, not your computer's. Use `--add-host` there instead.

```bash
docker run -d --name sage-ai \
	--network=host -v sage-ai-data:/app/backend/data \
	-e OLLAMA_BASE_URL=http://127.0.0.1:11434 \
	--restart always ghcr.io/sage-is/ai-ui:latest
```


## Podman on MacOS

[Podman](https://podman.io/) is a great Docker alternative. In most cases it's a complete drop in replacement. If you run into problems trouble shooting its a little different though.  

Here’s how to ensure connectivity:

1. **Enable Host Loopback**:
   Use `--network slirp4netns:allow_host_loopback=true` in your command.

2. **Set OLLAMA_BASE_URL**:
   Ensure it points to `http://host.containers.internal:11434`.

**Example Podman Command**:
```bash
podman run -d --name sage-is-ai-ui \
	--network slirp4netns:allow_host_loopback=true -p 3000:8080 \
	-e OLLAMA_BASE_URL=http://host.containers.internal:11434 \
	-v sage-ai-data:/app/backend/data \
	--restart always ghcr.io/sage-is/ai-ui:latest
```

We're going to be exploring migrating our official setup to [Podman](https://podman.io/)  in the future. If you have experience with this reach out and share your setup. 