#!/usr/bin/env bash

set +e

if [ "$(uname)" == "Darwin" ]; then
    echo "Running mac setup";
	./script/mac-init.sh
elif [ "$(uname)" == "Linux" ]; then
    echo "Running linux setup";
    ./script/linux-init.sh
else
    exit 0
fi