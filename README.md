
## Authors

- [@ronhadad22](https://github.com/ronhadad22)


# PolyBot


- This is a simple python telegram bot in a docker container.
- I built it in amd64 and arm64 in parallel and deployed it running the command
```bash
docker buildx build --platform linux/amd64,linux/arm64 --push -t .
```
## Deployment

To deploy this project run

```bash
docker run -d --platform linux/amd64 --restart always --name polybot docker.io/deanosaurx/polybot
```

If your machine is based on arm64 (m1 mac, etc..) run this instead

```bash
docker run -d --platform linux/arm64 --restart always --name polybot docker.io/deanosaurx/polybot
```
