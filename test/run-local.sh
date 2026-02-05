#!/bin/bash -e

workspace=$1

warn() {
  echo 1>&2 "$@"
}

error() {
  warn "$@"
  exit 1
}

[ "$workspace" ] || error "Usage: $0 <workspace>"

image='debsource-action:latest'
dir="$(dirname $0)/.."

docker build -t "$image" "$dir"

docker run --rm --workdir "/workspace" \
  -v "$workspace":"/workspace" \
  "$image"
