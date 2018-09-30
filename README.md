# Docker image for Samba with LDAP authentication

## Get configuration from image

```bash
docker create ydkn/samba:latest
docker cp $(docker ps -ql):/etc/samba .
docker cp $(docker ps -ql):/etc/nslcd.conf .
docker rm $(docker ps -ql)
```

## Modify configuration

Edit `nslcd.conf` and `smb.conf` to your needs.

## Adding users

```bash
docker run -it \
  -v $(pwd)/nslcd.conf:/etc/nslcd.conf \
  -v $(pwd)/samba:/etc/samba \
  -v $(pwd)/data:/var/lib/samba \
  ydkn/samba:latest \
  samba-user add <username>
```

## Start the container

```bash
docker run -d --restart always --net=host \
  -v $(pwd)/nslcd.conf:/etc/nslcd.conf \
  -v $(pwd)/samba:/etc/samba \
  -v $(pwd)/data:/var/lib/samba \
  ydkn/samba:latest
```
