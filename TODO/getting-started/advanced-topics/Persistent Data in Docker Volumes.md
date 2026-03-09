
The data is stored in a Docker volume named `sage-is-ai-ui`. The path to the volume is not directly accessible, but you can inspect the volume with the following command:

```bash
docker volume inspect sage-is-ai-ui
```

This will show you the details of the volume, including the mountpoint, which is usually located in `/var/lib/docker/volumes/sage-is-ai-ui/_data`.  

On Windows 10 + WSL 2, Docker volumes are located here (type in the Windows file explorer): 
 `\\\wsl$\docker-desktop\mnt\docker-desktop-disk\data\docker\volumes`
