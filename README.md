# Teltonika RUTOS SDK for Docker
Dockerized Toolchain for the RUTX series

```
docker build \
    --platform linux/amd64 \
    --pull \
    --build-arg RUTOS_VERSION=00.07.15.2 \
    --build-arg RUTOS_CHECKSUM=0d9cdfa4294a823f3dcc27a13cef15f0 \
    -f Dockerfile .
```

See also prebuild images here: 
https://github.com/paresy/docker-teltonika-rutos/pkgs/container/rutx-sdk