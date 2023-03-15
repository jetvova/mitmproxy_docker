#!/bin/bash
set -xeu

docker build --build-arg HOME=$HOME --build-arg UNAME=$(id -un) --build-arg UID=$(id -u) --build-arg GNAME=$(id -gn) --build-arg GID=$(id -g) -t mitmproxy .

PROJECT_DIR=$HOME/mitmproxy
docker run -ti --rm -v $PROJECT_DIR:$PROJECT_DIR -w $PROJECT_DIR --cap-add=NET_ADMIN mitmproxy
