# Docker image for Samba

## Get configuration from image

```bash
docker create ydkn/samba:latest
docker cp $(docker ps -ql):/etc/samba .
docker rm $(docker ps -ql)
```

## Modify configuration

Edit `smb.conf` to your needs.

## Adding users

```bash
docker run -it -v $(pwd)/samba:/etc/samba -v $(pwd)/data:/var/lib/samba ydkn/samba:latest samba-user add <username> <uid/gid>
```

## Start the container

```bash
docker run -d --restart always --net=host -v $(pwd)/samba:/etc/samba -v $(pwd)/data:/var/lib/samba ydkn/samba:latest
```
