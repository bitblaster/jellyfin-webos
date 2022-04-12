#!/bin/bash
CONTAINER_IMAGE="ghcr.io/oddstr13/docker-tizen-webos-sdk:webos-only"

MY=$(realpath "$(dirname $0)")
SSH_DIR=$(realpath ~/.ssh)

function ct {
  # The volume mount flag should be a lower case z.
  # NEVER upper case, as that could break permissions badly.
  # https://docs.docker.com/storage/bind-mounts/#configure-the-selinux-label
  docker container run -it --rm --user=$UID --network=host -v "${MY}":/home/developer:z -v "${SSH_DIR}":"/home/developer/.ssh":ro $CONTAINER_IMAGE "$@"
}

if [ $# -lt 1 ]; then
  echo "Available commands:"
  echo "bash               Enter container command line"
  ct ares --list
else
  ct "$@"
fi
