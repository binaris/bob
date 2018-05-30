# Docker image to build directory for bn.

# Usage:
#
#     docker  build --tag=pipper . && \
#     docker run --build-arg build_dir=$PWD -v /tmp/data/:/data/

FROM ubuntu:16.04 as base

# SciPy installer needs dependencies, and also NumPy already
# installed.  Cheat and install it first.
RUN apt-get update && apt-get install -y python-dev python-pip curl && apt-get build-dep -y python-scipy

# Directory to copy in for build.  After building, cp this out -- to
# the same place.  Otherwise pip will have to rebuild everything,
# every time.
RUN pip install virtualenv
COPY oldrequirements.txt /tmp/oldrequirements.txt
RUN virtualenv /tmp/tmpenv && /tmp/tmpenv/bin/pip install -r /tmp/oldrequirements.txt --src $HOME && rm -r /tmp/tmpenv
COPY requirements.txt /tmp/requirements.txt
RUN mkdir -p /tmp/dist
RUN pip install -t /tmp/dist -r /tmp/requirements.txt
