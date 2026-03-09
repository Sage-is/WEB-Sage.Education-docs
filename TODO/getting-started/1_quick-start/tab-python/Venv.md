
# Using Virtual Environments

Create isolated Python environments using `venv`.

## Steps

1. **Create a Virtual Environment:**

   ```bash
   python3 -m venv venv
   ```

2. **Activate the Virtual Environment:**

   - On Linux/macOS:

     ```bash
     source venv/bin/activate
     ```

   - On Windows:

     ```bash
     venv\Scripts\activate
     ```

3. **Install Sage.is AI-UI:**

   ```bash
   pip install sage-is-ai-ui
   ```

4. **Start the Server:**

   ```bash
   sage-is-ai-ui serve
   ```
