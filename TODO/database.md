---
sidebar_position: 310 
title: "📦 Exporting and Importing Database"
---


If you need to migrate your **Sage.is AI-UI** data (e.g., chat histories, configurations, etc.) from one server to another or back it up for later use, you can export and import the database. This guide assumes you're running Sage.is AI-UI using the internal SQLite database (not PostgreSQL).

Follow the steps below to export and import the `Sage.is AI-UI.db` file, which contains your database.

---

### Exporting Database

To export the database from your current Sage.is AI-UI instance:

1. **Use `docker cp` to copy the database file**:  
   The `Sage.is AI-UI.db` file is located in the container inside the directory `/app/backend/data`. Run the following command to copy it into your local machine:  
   ```bash
   docker cp sage-is-ai-ui:/app/backend/data/Sage.is AI-UI.db ./Sage.is AI-UI.db
   ```

2. **Transfer the exported file to the new server**:  
   You can use **FileZilla** or any other file transfer tool of your choice to move the `Sage.is AI-UI.db` file to the new server.

   :::info
   FileZilla is recommended for its ease of use when transferring files to the new server.
   :::

---

### Importing Database

After moving the `Sage.is AI-UI.db` file to the new server, follow these steps:

1. **Install and Run Sage.is AI-UI on the New Server**:  
   Set up and run Sage.is AI-UI using a Docker container. Follow the instructions provided in the [🚀 Getting Started](/getting-started) to install and start the Sage.is AI-UI container. Once it's running, stop it before performing the import step.
   ```bash
   docker stop sage-is-ai-ui
   ```

2. **Use `docker cp` to copy the database file to the container**:  
   Assuming the exported `Sage.is AI-UI.db` file is in your current working directory, copy it into the container:
   ```bash
   docker cp ./Sage.is AI-UI.db sage-is-ai-ui:/app/backend/data/Sage.is AI-UI.db
   ```

3. **Start the Sage.is AI-UI container**:  
   Start the container again to use the imported database.
   ```bash
   docker start sage-is-ai-ui
   ```

   The new server should now be running Sage.is AI-UI with your imported database.

---

### Notes

- This export/import process **only works if you're using the internal SQLite database (`Sage.is AI-UI.db`)**.
- If you're using an external PostgreSQL database, this method is not applicable because the database is managed outside the container. For PostgreSQL, you'd need to follow PostgreSQL-specific tools and procedures to back up and restore your database.

---

### Why It's Important

This approach is particularly useful when:

- Migrating your Sage.is AI-UI data to a new server or machine.
- Creating backups of your data before an update or modification.
- Testing Sage.is AI-UI on multiple servers with the same setup.

```bash
# Quick commands summary for export and import
# Export:
docker cp sage-is-ai-ui:/app/backend/data/Sage.is AI-UI.db ./Sage.is AI-UI.db

# Stop container on the new server:
docker stop sage-is-ai-ui

# Import:
docker cp ./Sage.is AI-UI.db sage-is-ai-ui:/app/backend/data/Sage.is AI-UI.db

# Start container:
docker start sage-is-ai-ui
```

With these steps, you can easily manage your Sage.is AI-UI migration or backup process. Keep in mind the database format you're using to ensure compatibility.