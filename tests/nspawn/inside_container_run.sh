#!/bin/bash

set -euo pipefail

REPO_SOURCE_MOUNT="/mnt/alis-src"
CONTAINER_WORKDIR=${ALIS_NSPAWN_WORKDIR:-"/opt/alis"}

if [[ -z "${CONTAINER_WORKDIR}" || "${CONTAINER_WORKDIR}" == "/" ]]; then
	echo "Refusing to use unsafe ALIS_NSPAWN_WORKDIR: '${CONTAINER_WORKDIR}'" >&2
	exit 1
fi

case "${CONTAINER_WORKDIR}" in
	/home/*|/opt/*|/tmp/*|/var/tmp/*) ;;
	*)
		echo "Refusing to rm -rf non-standard ALIS_NSPAWN_WORKDIR: '${CONTAINER_WORKDIR}' (expected /home/*, /opt/*, /tmp/*, or /var/tmp/*)" >&2
		exit 1
		;;
esac

rm -rf "${CONTAINER_WORKDIR}"
mkdir -p "${CONTAINER_WORKDIR}"
# Copy without trying to preserve host ownership (this runs as a non-root user).
cp -a --no-preserve=ownership "${REPO_SOURCE_MOUNT}/." "${CONTAINER_WORKDIR}"

cd "${CONTAINER_WORKDIR}"

if [ -n "${ALIS_TARGET_HARDWARES:-}" ]; then
	# Intentional word splitting so ALIS_TARGET_HARDWARES behaves like CLI args.
	# shellcheck disable=SC2206
	target_hardwares=(${ALIS_TARGET_HARDWARES})
	./configure-system.sh "${target_hardwares[@]}"
else
	./configure-system.sh
fi
