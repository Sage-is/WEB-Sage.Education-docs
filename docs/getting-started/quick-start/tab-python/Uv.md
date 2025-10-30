### Installation with `uv` 

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
