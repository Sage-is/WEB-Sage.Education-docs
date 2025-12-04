---
title: Begin with a Remote AI
---
When first getting started with using Sage.is AI-UI, connecting to a remote AI provider is often the easiest way to dive right in. This approach requires minimal setup and lets you start exploring AI capabilities immediately.

### 🎯 Why Start with Remote AI?
- **Zero installation complexity** - No local models to download or manage
- **Instant access** - Start using AI features within minutes
- **Cost-effective** - Pay only for what you use
- **Always up-to-date** - Access the latest models and features automatically

### 🚀 Quick Setup Guide

#### 1. Configure Your AI Provider
First, set up your preferred AI provider account:
- **OpenAI** - Get API keys from [platform.openai.com](https://platform.openai.com)
- **Anthropic** - Create account at [console.anthropic.com](https://console.anthropic.com)
- **Other providers** - Follow their specific setup instructions

#### 2. Launch Sage.is AI-UI
Open your local copy of Sage AI login as an administrator. Click on your username in the lower left-hand corner, opening the user menu. Now click on **Admin Panel**, then (in the Settings tab) click **Connections**. In Connections click on the **+** next to **Manage OpenAI Compatible API Connections** and configure your Connection using the provider's API Key and Base URL.

#### 3. Configure Your API Connection

Fill in the connection details:

- **Connection Name**: Choose a descriptive name (e.g., "OpenAI GPT-5", "Anthropic Claude", "Custom API")
- **API Key**: Enter the API key provided by your AI service
- **Base URL**: Use the API endpoint URL from your provider
- **Model Name**: Specify the model you want to use (e.g., "gpt-5", "claude-4-sonnet")

**Example for OpenAI:**

- Base URL: `https://api.openai.com/v1`
- Model Name: `gpt-5

**Example for Custom API:**

- Base URL: `https://your-api-endpoint.com/v1`
- Model Name: `your-model-name`

#### 4. Test and Save Your Connection

After entering all details:

- Click  🔄 "Verify Connection" to verify everything is working
- If successful, click "Save" to add the connection
- Your new API connection will now appear in the Connections list

#### 5. Start Using Remote AI Models

Once configured:

- Return to the main chat interface
- Your remote AI models will be available alongside any local ones
- Select your preferred model from the model dropdown menu
- Start chatting with your configured AI services! (optionally click **Set as default** to default to any model you prefer.)

:::note
**Tip**: You can configure multiple AI API connections simultaneously and switch between them as needed. You can even do this in a single chat! Or even send the same messages to more than one model at the same time!
:::