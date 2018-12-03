#!/bin/bash

BASE_DIR=$(dirname "$(readlink -f $0)")

cd ${BASE_DIR}

git clone https://github.com/ahmetb/kubectx.git
git clone https://github.com/jonmosco/kube-ps1.git
