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

tmpdir=$(mktemp -d)
cp $dir/Dockerfile $tmpdir

if [ -f $PWD/oldrequirements.txt ]; then
  cp $PWD/oldrequirements.txt $tmpdir
else
  cp $dir/oldrequirements.txt $tmpdir
fi

if [ -f $PWD/requirements.txt ]; then
  cp $PWD/requirements.txt $tmpdir
else
  cp $dir/requirements.txt $tmpdir
fi

$DOCKER build --tag=pipper $tmpdir
volume="-v $PWD/dist:/tmp/expectedout"

$DOCKER run --rm $volume pipper:latest bash -c "cp -r /tmp/dist/* /tmp/expectedout/" && build_status=0 || build_status=$? && true

rm -rf $tmpdir
exit $build_status
