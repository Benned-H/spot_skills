# Extra Docker Commands

To build and push the current essential services, run the commands:

```bash
docker compose --progress plain build --no-cache spot-tamp-v2 spot-tamp-mac-v2
docker compose --progress plain build --no-cache spot-tamp-gpu-v2
docker compose push spot-tamp-v2 spot-tamp-mac-v2 spot-tamp-gpu-v2
```
