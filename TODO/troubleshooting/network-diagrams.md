---
sidebar_position: 3
title: "🕸️ Network Diagrams"
---

Here, we provide clear and structured diagrams to help you understand how various components of the network interact within different setups. This documentation is designed to assist both macOS/Windows and Linux users. Each scenario is illustrated using Mermaid diagrams to show how the interactions are set up depending on the different system configurations and deployment strategies.

## Mac OS/Windows Setup Options 🖥️

### Ollama on Host, Sage.is AI-UI in Container

In this scenario, `Ollama` runs directly on the host machine while `Sage.is AI-UI` operates within a Docker container.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Mac OS/Windows") {
   Person(user, "User")
   Boundary(b1, "Docker Desktop's Linux VM") {
      Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
   }
   Component(ollama, "Ollama", "Listening on port 11434")
}
Rel(Sage.is AI-UI, ollama, "Makes API calls via Docker proxy", "http://host.docker.internal:11434")
Rel(user, Sage.is AI-UI, "Makes requests via exposed port -p 3000:8080", "http://localhost:3000")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

### Ollama and Sage.is AI-UI in Compose Stack

Both `Ollama` and `Sage.is AI-UI` are configured within the same Docker Compose stack, simplifying network communications.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Mac OS/Windows") {
   Person(user, "User")
   Boundary(b1, "Docker Desktop's Linux VM") {
      Boundary(b2, "Compose Stack") {
         Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
         Component(ollama, "Ollama", "Listening on port 11434")
      }
   }
}
Rel(Sage.is AI-UI, ollama, "Makes API calls via inter-container networking", "http://ollama:11434")
Rel(user, Sage.is AI-UI, "Makes requests via exposed port -p 3000:8080", "http://localhost:3000")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

### Ollama and Sage.is AI-UI, Separate Networks

Here, `Ollama` and `Sage.is AI-UI` are deployed in separate Docker networks, potentially leading to connectivity issues.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Mac OS/Windows") {
   Person(user, "User")
   Boundary(b1, "Docker Desktop's Linux VM") {
      Boundary(b2, "Network A") {
         Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
      }
      Boundary(b3, "Network B") {
         Component(ollama, "Ollama", "Listening on port 11434")
      }
   }
}
Rel(Sage.is AI-UI, ollama, "Unable to connect")
Rel(user, Sage.is AI-UI, "Makes requests via exposed port -p 3000:8080", "http://localhost:3000")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

### Sage.is AI-UI in Host Network

In this configuration, `Sage.is AI-UI` utilizes the host network, which impacts its ability to connect in certain environments.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Mac OS/Windows") {
   Person(user, "User")
   Boundary(b1, "Docker Desktop's Linux VM") {
      Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
   }
}
Rel(user, Sage.is AI-UI, "Unable to connect, host network is the VM's network")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```


## Linux Setup Options 🐧

### Ollama on Host, Sage.is AI-UI in Container (Linux)

This diagram is specific to the Linux platform, with `Ollama` running on the host and `Sage.is AI-UI` deployed inside a Docker container.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Linux") {
   Person(user, "User")
   Boundary(b1, "Container Network") {
      Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
   }
   Component(ollama, "Ollama", "Listening on port 11434")
}
Rel(Sage.is AI-UI, ollama, "Makes API calls via Docker proxy", "http://host.docker.internal:11434")
Rel(user, Sage.is AI-UI, "Makes requests via exposed port -p 3000:8080", "http://localhost:3000")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

### Ollama and Sage.is AI-UI in Compose Stack (Linux)

A set-up where both `Ollama` and `Sage.is AI-UI` reside within the same Docker Compose stack, allowing for straightforward networking on Linux.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Linux") {
   Person(user, "User")
   Boundary(b1, "Container Network") {
      Boundary(b2, "Compose Stack") {
         Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
         Component(ollama, "Ollama", "Listening on port 11434")
      }
   }
}
Rel(Sage.is AI-UI, ollama, "Makes API calls via inter-container networking", "http://ollama:11434")
Rel(user, Sage.is AI-UI, "Makes requests via exposed port -p 3000:8080", "http://localhost:3000")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

### Ollama and Sage.is AI-UI, Separate Networks (Linux)

A scenario in which `Ollama` and `Sage.is AI-UI` are in different Docker networks under a Linux environment, which could hinder connectivity.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Linux") {
   Person(user, "User")
   Boundary(b2, "Container Network A") {
      Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
   }
   Boundary(b3, "Container Network B") {
      Component(ollama, "Ollama", "Listening on port 11434")
   }
}
Rel(Sage.is AI-UI, ollama, "Unable to connect")
Rel(user, Sage.is AI-UI, "Makes requests via exposed port -p 3000:8080", "http://localhost:3000")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

### Sage.is AI-UI in Host Network, Ollama on Host (Linux)

An optimal layout where both `Sage.is AI-UI` and `Ollama` use the host’s network, facilitating seamless interaction on Linux systems.

```mermaid
C4Context
Boundary(b0, "Hosting Machine - Linux") {
   Person(user, "User")
   Component(Sage.is AI-UI, "Sage.is AI-UI", "Listening on port 8080")
   Component(ollama, "Ollama", "Listening on port 11434")
}
Rel(Sage.is AI-UI, ollama, "Makes API calls via localhost", "http://localhost:11434")
Rel(user, Sage.is AI-UI, "Makes requests via listening port", "http://localhost:8080")
UpdateRelStyle(user, Sage.is AI-UI, $offsetX="-100", $offsetY="-50")
```

Each setup addresses different deployment strategies and networking configurations to help you choose the best layout for your requirements.
