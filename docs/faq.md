---
title: "Sage.is FAQ"
---

import { TopBanners } from "@site/src/components/TopBanners";

<TopBanners />

## 

### 💡 Why Docker?

We understand Docker might not be everyone’s preference; however, this approach is central to our project’s design and efficiency. We see Docker as fundamental and encourage those seeking other deployment methods to explore community-driven alternatives.

### How do I customize the logo and branding?

You can customize the theme, logo, and branding directly from the Admin Panel. No enterprise license is required for these features.

For more details on enterprise solutions and advanced branding customizations, please contact our sales team at: 📧 [sales@sage.is](mailto:sales@sage.is)

### Why am I asked to sign up? Where are my data being sent to?

We ask you to sign up so you can be the admin user. This adds security. If your [Sage.is](http://Sage.is) AI-UI instance is open to the outside world, your data stays safe. Everything is kept local. We do not collect your data. When you sign up, all info stays on your server and never leaves your device. Your privacy and security are our top priorities. Your data is always under your control.

### Why can’t my Docker container connect to services on the host using localhost?

Think of a Docker container as its own world. Inside it, localhost means the container itself, not your computer. To connect to services on your computer, use host.docker.internal. Docker uses this name to let the container talk to your host machine. This is a simple way to connect your container to your computer.

### How do I make my host’s services accessible to Docker containers?

To make local host services accessible to Docker containers, configure them to listen on all network interfaces using 0.0.0.0 instead of 127.0.0.1, which is limited to localhost. This allows services to accept connections from any IP address, including Docker containers. Be aware of the security implications, especially in environments with external access. Use security measures such as firewalls and authentication to reduce risk.

### Why isn’t my [Sage.is](http://Sage.is) AI-UI updating? I’ve re-pulled/restarted the container, and nothing changed.

Updating [Sage.is](http://Sage.is) AI-UI requires more than pulling the new Docker image. Here’s why your updates might not show and how to ensure they do:

1. Updating the Docker Image: The command docker pull ghcr.io/Startr/AI-WEB-openwebui:main updates the Docker image but not the running container or its data.
2. Persistent Data in Docker Volumes: Docker volumes store data independently of container lifecycles, preserving your data (such as chat histories) across updates.
3. Applying the Update: Make sure your update takes effect by removing the existing container (which doesn’t delete the volume) and creating a new one with the updated image and existing volume attached.

This process updates the app while keeping your data safe.

### Wait, why would I delete my container? Won’t I lose my data?

It’s a common concern, but deleting a container doesn’t mean you’ll lose your data if you use Docker volumes correctly. Here’s why:

- Volumes Preserve DatDocker volumes are designed to persist data outside of container lifecycles. As long as your data is stored in a volume, it remains intact, regardless of what happens to the container.
- Safe Update Process: When updating [Sage.is](http://Sage.is) AI-UI, removing the old container and creating a new one with the updated image does not affect data stored in volumes. The key is not to delete the volume with commands like docker volume rm.

By following the correct update steps—pulling the new image, removing the old container without deleting the volume, and creating a new container with the updated image and existing volume—your application code is updated while your data remains safe.

### Should I use the distro-packaged Docker or the official Docker package?

We recommend using the official Docker package over distro-packaged versions for running [Sage.is](http://Sage.is) AI-UI. The official package is updated with the latest features, bug fixes, and security patches, ensuring optimal performance and security. It also supports important features like host.docker.internal, which may not be available in distro-packaged versions. This is essential for proper network configurations and connectivity within Docker containers.

By choosing the official Docker package, you get consistent behavior across environments, more reliable troubleshooting, and access to the latest Docker advancements. The broader Docker community and resources are also more aligned with the official package, providing you with a wealth of information and support for any issues you might encounter.

Everything you need to run [Sage.is](http://Sage.is) AI-UI, including your data, stays within your control and your server environment, emphasizing our commitment to your privacy and security. For instructions on installing the official Docker package, see the [Install Docker Engine](https://docs.docker.com/engine/install/) guide on Docker’s official documentation site.

### Is GPU support available in Docker?

GPU support in Docker is available but varies by platform. Officially, GPU support is provided in Docker for Windows and Docker Engine on Linux. Other platforms, such as Docker Desktop for Linux and MacOS, do not currently offer GPU support. This is important to consider for applications needing GPU acceleration. For the best experience and to use GPU capabilities, we recommend Docker on platforms that officially support GPU integration.

### Why does [Sage.is](http://Sage.is) AI-UI emphasize the use of Docker?

The decision to use Docker comes from its ability to ensure consistency, isolate dependencies, and simplify deployment across environments. Docker minimizes compatibility issues and streamlines getting the WebUI running on different systems. While Docker has a learning curve, its deployment and maintenance advantages are significant. We understand Docker might not be everyone’s preference; however, this approach is central to our project’s design and efficiency. We see Docker as fundamental and encourage those seeking alternative deployment methods to explore community-driven alternatives.

### Why doesn’t Speech-to-Text (STT) and Text-to-Speech (TTS) work in my deployment?

Speech-to-Text (STT) and Text-to-Speech (TTS) services may require HTTPS to work correctly. Modern browsers restrict features like STT and TTS to secure HTTPS connections. If your deployment is not using HTTPS, these services might not function as expected. Making your deployment accessible over HTTPS can resolve these issues and enable full STT/TTS functionality.

### Why doesn’t [Sage.is](http://Sage.is) AI-UI include built-in HTTPS support?

While we understand the desire for an all-in-one solution with HTTPS support, we believe this would not serve the diverse needs of our users. Implementing HTTPS directly could limit flexibility and may not fit everyone’s requirements. To let users tailor their setup, we leave HTTPS termination to users for production deployments. This allows for greater adaptability and customization. Though we don’t offer official documentation on HTTPS setup, community members may provide guidance upon request.

### I updated/restarted/installed some new software and now [Sage.is](http://Sage.is) AI-UI isn’t working anymore!

If your [Sage.is](http://Sage.is) AI-UI isn’t launching after an update or new software installation, it’s likely due to a direct installation, especially if you didn’t use a virtual environment for backend dependencies. Direct installations are sensitive to system changes, such as updates that alter dependencies. To avoid conflicts and ensure stability, we only support instalation using Docker or Podman at this time.

### I updated/restarted, and now my login isn’t working anymore. I had to create a new account and all my chats are gone.

This issue usually happens when a Docker container is created without mounting a volume for /app/backend/data or if the [Sage.is](http://Sage.is) AI-UI volume (usually named sage-open-webui) was deleted. Docker volumes are crucial for keeping your data across container lifecycles. If you need to create a new account after a restart, you likely started a new container without attaching the existing volume. Make sure your Docker run command includes a volume mount pointing to the correct data location to prevent data loss.

### I tried to login and couldn’t, made a new account and now I’m being told my account needs to be activated by an admin.

This happens when you forget the password for the initial admin account created during setup. The first account is automatically the admin. Creating a new account without admin access will require admin activation. Keeping the initial admin credentials is crucial for managing [Sage.is](http://Sage.is) AI-UI. See the [Resetting the Admin Password](http://troubleshooting/password-reset) guide for recovery instructions.

### Why can’t [Sage.is](http://Sage.is) AI-UI start with an SSL error?

The SSL error when starting [Sage.is](http://Sage.is) AI-UI is likely due to missing SSL certificates or incorrect huggingface.co configuration. To fix this, set up a HuggingFace mirror like hf-mirror.com and specify it as the endpoint when starting the Docker container. Use the -e HF_ENDPOINT=https://hf-mirror.com/ parameter in the Docker run command. For example, modify the Docker run command as follows:

docker run -d -p 3000:8080 -e HF_ENDPOINT=https://hf-mirror.com/ --add-host=host.docker.internal:host-gateway -v sage-open-webui:/app/backend/data --name sage-open-webui --restart always ghcr.io/Startr/AI-WEB-openwebui:main

Need Further Assistance?

If you have further questions or concerns, reach out to our [GitHub Issues page](https://github.com/Startr/AI-WEB-openwebui/issues) or [Discord channel](https://discord.com/channels/1074411230040703046/1074411231030550632) for more help and information.
