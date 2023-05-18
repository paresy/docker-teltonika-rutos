# Teltonika RUTOS SDK for Docker
Dockerized Toolchain for the RUTX series

```
docker build \
    --platform linux/amd64 \
    --pull \
    --build-arg RUTOS_VERSION=00.07.04.2 \
    --build-arg RUTOS_CHECKSUM=332c6e066f7d74670af65938f1312dc5 \
    -f Dockerfile .
```

See also prebuild images here: 
https://github.com/paresy/docker-teltonika-rutos/pkgs/container/rutx-sdk