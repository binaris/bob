#!/bin/bash

# Builds bolt-compatible packages from Python requirements, and copies
# them back out to CWD.

dir=`dirname $0`

if [ -w /var/run/docker.sock ]; then
    DOCKER=docker
else
    DOCKER='sudo docker'
fi

mkdir -p .binaris/.pycache dist

$DOCKER build --tag=pipper $dir # Keep going even on failure!
if [ -f ./requirements.txt ]; then
  volume="-v $PWD/requirements.txt:/function/requirements.txt"
else
  volume=''
fi
$DOCKER run $volume pipper:latest
build_status=$?
$DOCKER run pipper:latest bash -c 'tar -C /cache -cz .' | tar -x --keep-newer -C .binaris/.pycache/
$DOCKER run pipper:latest bash -c 'tar -C /function -cz .' | tar -x --keep-newer -C dist/
exit $build_status
