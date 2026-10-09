
Docker Compose is a tool for defining and running multi-container applications. If you or your team is using Docker Compose you can integrate Watchtower with a Docker `compose.yaml` file.

```yml
services:
  sage-ai:
    image: ghcr.io/sage-is/ai-ui:latest
    ports:
      - "8080:8080"
    extra_hosts:
      - "host.docker.internal:host-gateway"
    volumes:
      - sage-ai-data:/app/backend/data

  watchtower:
    image: containrrr/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --interval 300 sage-ai
    depends_on:
      - sage-ai

volumes:
  sage-ai-data:
```

`extra_hosts` lets Sage reach services on your computer, such as Ollama, at `host.docker.internal`. Docker Engine on Linux needs it; Colima, Docker Desktop and OrbStack accept it too.

This Docker `compose.yaml` file will deploy both Sage.is AI-UI and Watchtower. Setting Watchtower  to check for updates every 300 seconds (5 minutes) for the Sage.is AI-UI container.