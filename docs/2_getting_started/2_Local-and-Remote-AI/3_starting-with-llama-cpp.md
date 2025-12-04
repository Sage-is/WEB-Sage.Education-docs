---
sidebar_position: 3
title: Local with Llama.cpp
---
:::tip
#### **For Beginners: Start with [Ollama](2_starting-with-ollama.md)**

If you're new to local AI, we recommend beginning with **[Ollama](2_starting-with-ollama.md)** - it's more user-friendly and perfect for getting started quickly.
#### **For Advanced Users: Llama.cpp**

Once you're comfortable with local AI setup, consider **[Llama.cpp](2_starting-with-ollama.md)** for maximum performance and flexibility. It offers superior speed and power, though requires more technical configuration.
:::
## Overview

With Sage.is AI-UI you can quickly connect and manage the powerful and fast local Llama.cpp server to run efficient, quantized language models. Whether you’ve compiled Llama.cpp yourself or you're using precompiled binaries, this guide will walk you through how to:

- Set up your Llama.cpp server
- Load large language models locally
- Integrate with Sage.is AI-UI for a seamless interface

Let’s get you started!



---

## Step 1: Install Llama.cpp

To run models with Llama.cpp, you first need the Llama.cpp server installed locally.

You can either:

- 📦 [Download prebuilt binaries](https://github.com/ggerganov/llama.cpp/releases)
- Or build it from source by following the 🔗 [official build instructions](https://github.com/ggerganov/llama.cpp/blob/master/docs/build.md)

After installing, make sure `llama-server` is available in your local system path or take note of its location.

---

## Step 2: Download a Supported Model

You can load and run various GGUF-format quantized LLMs using Llama.cpp. One impressive example is the DeepSeek-R1 1.58-bit model optimized by UnslothAI. To download this version:

1. Visit the [Unsloth Phi-4 repository on Hugging Face](https://huggingface.co/unsloth/phi-4-GGUF)
2. Download the 2-bit quantized version – around just 5.73GB!

Alternatively, use Python to download programmatically:

```python

# pip install huggingface_hub hf_transfer

from huggingface_hub import snapshot_download

snapshot_download(
    repo_id = "https://huggingface.co/unsloth/phi-4-GGUF",
    local_dir = "Phi-4-GGUF",
    allow_patterns = ["*UD-IQ1_S*"],  # Download only 2-bit variant
)
```

This will download the model files into a directory like:
```
Phi-4-GGUF
```

📍 Keep track of the full path to the first GGUF file — you’ll need it in Step 3.

---

## Step 3: Serve the Model with Llama.cpp

Start the model server using the llama-server binary. Navigate to your llama.cpp folder (e.g., build/bin) and run:

```bash
./llama-server \
  --model /your/full/path/to/Phi-4-GGUF-UD-IQ1_S-00001-of-00003.gguf \
  --port 10000 \
  --ctx-size 1024 \
  --n-gpu-layers 40
```

🛠️ Tweak the parameters to suit your machine:

- --model: Path to your .gguf model file
- --port: 10000 (or choose another open port)
- --ctx-size: Token context length (can increase if RAM allows)
- --n-gpu-layers: Layers offloaded to GPU for faster performance

Once the server runs, it will expose a local OpenAI-compatible API on:

```
http://127.0.0.1:10000
```

---

## Step 4: Connect Llama.cpp to Sage.is AI-UI

To control and query your locally running model directly from Sage.is AI-UI:

1. Open Sage.is AI-UI in your browser
2. Go to ⚙️ Admin Settings → Connections → OpenAI Connections
3. Click ➕ Add Connection and enter:

- URL: `http://127.0.0.1:10000/v1`
  (Or use `http://host.docker.internal:10000/v1` if running Sage.is AI-UI inside Docker)
- API Key: `none` (leave blank)

💡 Once saved, Sage.is AI-UI will begin using your local Llama.cpp server as a backend!

![Llama.cpp Connection in Sage.is AI-UI](/images/tutorials/deepseek/connection.png)

---

## Quick Tip: Try Out the Model via Chat Interface

Once connected, select the model from the Sage.is AI-UI chat menu and start interacting!

---

## You're Ready to Go!

Once configured, Sage.is AI-UI makes it easy to:

- Manage and switch between local models served by Llama.cpp
- Use the OpenAI-compatible API with no key needed
- Experiment with massive models like Phi-4 or even DeepSeek-R1 — right from your machine!

---

If you run into any issues or need more guidance, check out our [help section](/troubleshooting) for detailed solutions. Enjoy using Ollama with Sage.is AI-UI! 🎉