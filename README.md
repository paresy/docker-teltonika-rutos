# Teltonika RUTOS SDK for Docker
Dockerized Toolchain for the RUTX series

```
docker build \
    --platform linux/amd64 \
    --pull \
    --build-arg RUTOS_VERSION=00.07.09.1 \
    --build-arg RUTOS_CHECKSUM=d02b04fd41487113df3629cbdad3b63c \
    -f Dockerfile .
```

See also prebuild images here: 
https://github.com/paresy/docker-teltonika-rutos/pkgs/container/rutx-sdk