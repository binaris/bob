#!/bin/bash

# Builds bolt-compatible packages from Python requirements, and copies
# them back out to CWD.

set -euo pipefail

dir=`dirname $0`

if [ -w /var/run/docker.sock ]; then
    DOCKER=docker
else
    DOCKER='sudo docker'
fi

mkdir -p .binaris/.pycache dist

$DOCKER build --tag=pipper $dir
if [ -f ./requirements.txt ]; then
  volume="-v $PWD/requirements.txt:/function/requirements.txt"
else
  volume=''
fi
$DOCKER run --rm $volume pipper:latest && build_status=0 || build_status=$? && true
$DOCKER run --rm pipper:latest bash -c 'tar -C /cache -cz .' | tar -x --keep-newer -C .binaris/.pycache/ || true
$DOCKER run --rm pipper:latest bash -c 'tar -C /function -cz .' | tar -x --keep-newer -C dist/ || true
exit $build_status
