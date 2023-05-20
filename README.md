# Teltonika RUTOS SDK for Docker
Dockerized Toolchain for the RUTX series

```
docker build \
    --platform linux/amd64 \
    --pull \
    --build-arg RUTOS_VERSION=00.07.04.3 \
    --build-arg RUTOS_CHECKSUM=2a05900c79e3dacf3d65b2835a855b93 \
    -f Dockerfile .
```

See also prebuild images here: 
https://github.com/paresy/docker-teltonika-rutos/pkgs/container/rutx-sdk