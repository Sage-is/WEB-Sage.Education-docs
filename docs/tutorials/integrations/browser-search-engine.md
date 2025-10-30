---
sidebar_position: 16
title: "🌐 Browser Search Engine"
---

:::warning
This tutorial is a community contribution and is not supported by the Sage.is AI-UI team. It serves only as a demonstration on how to customize Sage.is AI-UI for your specific use case. Want to contribute? Check out the contributing tutorial.
:::

# Browser Search Engine Integration

Sage.is AI-UI allows you to integrate directly into your web browser. This tutorial will guide you through the process of setting up Sage.is AI-UI as a custom search engine, enabling you to execute queries easily from your browser's address bar.

## Setting Up Sage.is AI-UI as a Search Engine

### Prerequisites

Before you begin, ensure that:

- You have Chrome or another supported browser installed.
- The `WEBUI_URL` environment variable is set correctly, either using Docker environment variables or in the `.env` file as specified in the [Getting Started](/getting-started/env-configuration) guide.

### Step 1: Set the WEBUI_URL Environment Variable

Setting the `WEBUI_URL` environment variable ensures your browser knows where to direct queries.

#### Using Docker Environment Variables

If you are running Sage.is AI-UI using Docker, you can set the environment variable in your `docker run` command:

```bash
docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v sage-is-ai-ui:/app/backend/data \
  --name sage-is-ai-ui \
  --restart always \
  -e WEBUI_URL="https://<your-sage-is-ai-ui-url>" \
  ghcr.io/Startr/AI-WEB-openwebui:main
```

Alternatively, you can add the variable to your `.env` file:

```plaintext
WEBUI_URL=https://<your-sage-is-ai-ui-url>
```

### Step 2: Add Sage.is AI-UI as a Custom Search Engine

### For Chrome

1. Open Chrome and navigate to **Settings**.
2. Select **Search engine** from the sidebar, then click on **Manage search engines**.
3. Click **Add** to create a new search engine.
4. Fill in the details as follows:
    - **Search engine**: Sage.is AI-UI Search
    - **Keyword**: webui (or any keyword you prefer)
    - **URL with %s in place of query**:

      ```
      https://<your-sage-is-ai-ui-url>/?q=%s
      ```

5. Click **Add** to save the configuration.

### For Firefox

1. Go to Sage.is AI-UI in Firefox.
2. Expand the address bar by clicking on it.
3. Click the plus icon that is enclosed in a green circle at the bottom of the expanded address bar. This adds Sage.is AI-UI's search to the search engines in your preferences.

Alternatively:

1. Go to Sage.is AI-UI in Firefox.
2. Right-click on the address bar.
3. Select "Add Sage.is AI-UI" (or similar) from the context menu.

### Optional: Using Specific Models

If you wish to utilize a specific model for your search, modify the URL format to include the model ID:

```
https://<your-sage-is-ai-ui-url>/?models=<model_id>&q=%s
```

**Note:** The model ID will need to be URL-encoded. Special characters like spaces or slashes need to be encoded (e.g., `my model` becomes `my%20model`).

## Example Usage

Once the search engine is set up, you can perform searches directly from the address bar. Simply type your chosen keyword followed by your query:

```
webui your search query
```

This command will redirect you to the Sage.is AI-UI interface with your search results.

## Troubleshooting

If you encounter any issues, check the following:

- Ensure the `WEBUI_URL` is correctly configured and points to a valid Sage.is AI-UI instance.
- Double-check that the search engine URL format is correctly entered in your browser settings.
- Confirm your internet connection is active and that the Sage.is AI-UI service is running smoothly.
