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

RUN mkdir /function/ /cache/
ADD dist /function
ADD .binaris/.pycache /cache
COPY docker/* /function/
WORKDIR /function/

# Re-use PIP cache between runs.  Do *NOT* copy this out!
ENV XDG_CACHE_HOME=/cache/

CMD [ "./install.sh" ]
