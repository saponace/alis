#!/bin/bash

set -euo pipefail

PACMAN_CACHE_DIR=${PACMAN_CACHE_DIR:-"/var/cache/alis-vm/pacman-pkg"}

if [ "$(id -u)" -ne 0 ]; then
	echo "Run as root (e.g. sudo tests/qcow/setup_host_pacman_cache.sh)" >&2
	exit 1
fi

mkdir -p "${PACMAN_CACHE_DIR}"

if getent group libvirt-qemu >/dev/null 2>&1; then
	chgrp libvirt-qemu "${PACMAN_CACHE_DIR}"
	chmod 2775 "${PACMAN_CACHE_DIR}"
	echo "Created ${PACMAN_CACHE_DIR} (group libvirt-qemu, mode 2775)"
elif getent group qemu >/dev/null 2>&1; then
	chgrp qemu "${PACMAN_CACHE_DIR}"
	chmod 2775 "${PACMAN_CACHE_DIR}"
	echo "Created ${PACMAN_CACHE_DIR} (group qemu, mode 2775)"
else
	chmod 777 "${PACMAN_CACHE_DIR}"
	echo "Created ${PACMAN_CACHE_DIR} (mode 777; no qemu/libvirt group found)"
fi
