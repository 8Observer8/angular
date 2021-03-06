#!/bin/bash
set -eux -o pipefail

# Set up env
source "`dirname $0`/env.sh"
readonly defaultImageNameAndTag="aio-builds:latest"

# Build `scripts-js/`
cd "$SCRIPTS_JS_DIR"
yarn install
yarn run build
cd -

# Create docker image
readonly nameAndOptionalTag=${1:-$defaultImageNameAndTag}
sudo docker build --tag $nameAndOptionalTag ${@:2} $DOCKERBUILD_DIR
