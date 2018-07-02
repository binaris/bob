# Building with Bob

## About

Bob builds and packages `pip` dependencies for your functions using a container compatible with the Binaris runtime environment. By default `Bob` outputs dependencies to `$CWD/dist` (dir is created if non-existent).

## Quickstart

1. Create a Binaris Python2 function using 

   `bn create python2 foofunc`
2. Add your pip dependencies to a `requirements.txt` file in your function directory
3. Run `/path/to/bob/build.sh` to build the dependencies listed in `requirements.txt`
4. `bn deploy foofunc`

Step *3* should be repeated anytime `requirements.txt` is modified or changed

## Caching

You can substantially reduce build times by running

`cp requirements.txt oldrequirements.txt`

which allows your existing dependencies to be cached on subsequent builds.

### Why oldrequirements.txt?

`Bob` looks for the optional file `oldrequirements.txt` in the same directory where `requirements.txt` resides.

`oldrequirements.txt` can be viewed as a stable-state or checkpoint for `pip` dependencies listed in `requirements.txt`.

If the file is defined, `Bob` will build a cached state from the `oldrequirements.txt` dependencies which future module installations can utilize before fetching from the remote registry. In other words, on subsequent builds only the modules that are listed in `requirements.txt` and NOT listed in `oldrequirements.txt` will be fetched and downloaded. 
