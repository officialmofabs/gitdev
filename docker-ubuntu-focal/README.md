# docker-ubuntu

base ubuntu with some basic utilities and settings

## build image

```sh
git clone https://github.com/devel0/docker-ubuntu.git
cd docker-ubuntu
git checkout server-mgr
./build.sh
```

you can specify addictional docker build arguments, example:

```sh
./build.sh --network=dkbuild
```

## run image

follow create a test named container running an interactive bash terminal

```sh
docker run --name=test -ti searchathing/ubuntu:server-mgr
```

## override default command

default cmd is to execute a /bin/bash.
follow create, execute and remove a container executing a command

```sh
docker run --rm=true searchathing/ubuntu:server-mgr ls
```

## container timezone

can be set through TZ environment variable as shown follow examples

```sh
# docker run --rm=true searchathing/ubuntu:server-mgr date
Tue Feb 27 18:00:38 UTC 2018

# docker run -e TZ="Europe/Rome" --rm=true searchathing/ubuntu:server-mgr date
Tue Feb 27 19:00:41 CET 2018
```

## dynamic entrypoints

on [derived images](https://github.com/devel0/docker-rdp/blob/75b0fd9a84cdef4a7c4e51dda318fc31de959ac5/Dockerfile#L5) you can set addictional entrypoints by placing an executable script in /entrypoint.d directory
