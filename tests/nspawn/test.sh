#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ALIS_NSPAWN_BASE_ROOTFS=${ALIS_NSPAWN_BASE_ROOTFS:-"/var/lib/machines/alis"}

if [ "$(id -u)" -ne 0 ]; then
	echo "Run tests/nspawn/test.sh with sudo so systemd-nspawn can start the container" >&2
	exit 1
fi

if [ ! -d "${ALIS_NSPAWN_BASE_ROOTFS}" ]; then
	echo "Base rootfs not found at ${ALIS_NSPAWN_BASE_ROOTFS}; creating it first"
	ALIS_NSPAWN_BASE_ROOTFS="${ALIS_NSPAWN_BASE_ROOTFS}" "${SCRIPT_DIR}/create_rootfs.sh"
else
	echo "Using existing base rootfs at ${ALIS_NSPAWN_BASE_ROOTFS}"
fi

ALIS_NSPAWN_BASE_ROOTFS="${ALIS_NSPAWN_BASE_ROOTFS}" "${SCRIPT_DIR}/run_case.sh"
