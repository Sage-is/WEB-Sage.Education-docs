
Docker Compose is a tool for defining and running multi-container applications. If you or your team is using Docker Compose you can integrate Watchtower with a Docker `compose.yaml` file.

```yml
version: '3'
services:
  sage-is-ai-ui:
    image: ghcr.io/Sage-is/AI-UI:master
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

This Docker `compose.yaml` file will deploy both Sage.is AI-UI and Watchtower. Setting Watchtower  to check for updates every 300 seconds (5 minutes) for the Sage.is AI-UI container.