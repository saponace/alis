#!/bin/bash

set -euo pipefail

REPO_SOURCE_MOUNT="/mnt/alis-src"
CONTAINER_WORKDIR=${ALIS_NSPAWN_WORKDIR:-"/opt/alis"}

rm -rf "${CONTAINER_WORKDIR}"
mkdir -p "${CONTAINER_WORKDIR}"
cp -a "${REPO_SOURCE_MOUNT}/." "${CONTAINER_WORKDIR}"

cd "${CONTAINER_WORKDIR}"

if [ -n "${ALIS_TARGET_HARDWARES:-}" ]; then
	# Intentional word splitting so ALIS_TARGET_HARDWARES behaves like CLI args.
	# shellcheck disable=SC2206
	target_hardwares=(${ALIS_TARGET_HARDWARES})
	./configure-system.sh "${target_hardwares[@]}"
else
	./configure-system.sh
fi
