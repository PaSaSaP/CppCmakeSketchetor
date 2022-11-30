#!/bin/sh

if [[ $# != 1 ]]; then
    echo "pass dir name as parameter" >&2
    exit 1
fi

if test -d "$1"; then
    echo "directory $1 currently exists, skipping..."
    exit 1
fi

set -e
mkdir "$1"
mkdir "$1/src" "$1/build"
SCRIPT_DIR=$(dirname $(realpath $0))
cp "${SCRIPT_DIR}/CMakeLists.txt" "${SCRIPT_DIR}/.gitignore" "$1/"
cp "${SCRIPT_DIR}/src"/* "$1/src/"
cd "$1/build"
cmake ..
make
cd ..
git init .
git add .
git commit -m "Initial commit."

