#!/bin/bash
set -exuo pipefail

# Installation script for requirements.txt to get around weird
# installers for scipy and scikit-learn.  Assumes scipy dependencies
# are already installed.

PIP='pip install -t ./ --install-option=--prefix='

export PYTHONPATH=$PWD          # So scikit-learn installer sees
                                # current installations in this dir.

$PIP `grep '^numpy' requirements.txt`
$PIP `grep '^scipy' requirements.txt`
$PIP -r <(grep -v -e numpy -e scipy requirements.txt)
