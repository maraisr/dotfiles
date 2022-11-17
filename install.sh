#!/usr/bin/env bash

set +e

if [ "$(uname)" == "Darwin" ]; then
    echo "+---------------------+";
    echo "+ Mac Setup           +";
    echo "+---------------------+";
	./init/mac.sh
elif [ "$CODESPACES" == "true" ]; then
    echo "+---------------------+";
    echo "+ Codespace Setup     +";
    echo "+---------------------+";
    ./init/codespace.sh
else
    exit 0
fi

echo "+---------------------+";
echo "+ Bootstrapping...    +";
echo "+---------------------+";
./script/bootstrap.fish
