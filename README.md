# Teltonika RUTOS SDK for Docker
Dockerized Toolchain for the RUTX series

```
docker build \
    --platform linux/amd64 \
    --pull \
    --build-arg RUTOS_VERSION=00.07.14.2 \
    --build-arg RUTOS_CHECKSUM=eca6302c7a431e1f1934f90e27892d7f \
    -f Dockerfile .
```

See also prebuild images here: 
https://github.com/paresy/docker-teltonika-rutos/pkgs/container/rutx-sdk