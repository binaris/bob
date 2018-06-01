# Building with Bob

## About

Bob builds and packages `pip` dependencies to be compatible with the Binaris function runtime environment.

## Quickstart

1. Create a Binaris Python2 function using 

   `bn create python2 foofunc`
2. Add your pip dependencies to a `requirements.txt` file in your function directory
3. Run `/path/to/bob/build.sh` to build the dependencies listed in `requirements.txt`
4. `bn deploy foofunc`

Step *3* should be repeated anytime `requirements.txt` is modified or changed

## Caching

For most users, creating a copy of their existing `requirements.txt` by running

`cp requirements.txt oldrequirements.txt`

works well enough as a cache to substantially reduce build times.

### Why oldrequirements.txt?

`Bob` looks for the optional file `oldrequirements.txt` in the same directory where `requirements.txt` resides.

`oldrequirements.txt` can be viewed as a stable-state or checkpoint for `pip` dependencies listed in `requirements.txt`.

If the file is defined, `Bob` will build a cached state from the `oldrequirements.txt` dependencies which future module installations can utilize before fetching from the remote registry. In other words, on subsequent builds only the modules that are listed in `requirements.txt` and NOT listed in `oldrequirements.txt` will be fetched and downloaded. 
