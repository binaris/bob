# Bob builds your dependencies

## About

Bob helps deploy Binaris functions that have native-code dependencies.
It is required when the development platform does not match the
Binaris platform.

In future Binaris shall focus on a set of known binary dependencies
built into the platform.  In the meantime, use Bob.

## Platforms

### SciPy

SciPy-Bob lets you depend on NumPy, SciPy and SciKit-learn.

To use SciPy-Bob:

1. Go to your Binaris directory or create one using `bn create python2 <function name>`.
2. (Optional) Add `requirements.txt` (otherwise it uses a useful default).
3. Run `/path/to/bob/scipy/build.sh` to build dependencies.
4. `bn deploy functionName`.

Steps 1-3 build dependencies in the `dist/` subdirectory.  There is no
need to repeat them unless `requirements.txt` changes.  The results
are cached, to speed up future dependency builds.
