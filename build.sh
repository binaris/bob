#!/bin/bash

# Builds bolt-compatible packages from Python requirements, and copies
# them back out to CWD.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Please specify python version 2 or 3"
    exit 1
elif [ "$1" == "2" ]; then
   py_version=
elif [ "$1" == "3" ]; then
   py_version=3
else
  echo "Unsupported python version, please either use '2' or '3'"
  exit 1
fi

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

$DOCKER build --tag=pipper --build-arg py_version=$py_version $tmpdir
volume="-v $PWD/dist:/tmp/expectedout"

$DOCKER run --rm $volume pipper:latest bash -c "cp -r /tmp/dist/* /tmp/expectedout/" && build_status=0 || build_status=$? && true

rm -rf $tmpdir
exit $build_status
