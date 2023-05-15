# Teltonika RUTOS
Dockerized Toolchain for the RUTX series

```
docker build \
       --pull \
       --build-arg RUTOS_VERSION=RUTX_R_GPL_00.07.04.2.tar.gz \
       --build-arg RUTOS_CHECKSUM=332c6e066f7d74670af65938f1312dc5 \
       -f Dockerfile .
```

See also prebuild images here: https://github.com/paresy?tab=packages