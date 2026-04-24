#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." && pwd)
ALIS_NSPAWN_ROOTFS=${ALIS_NSPAWN_ROOTFS:-""}
ALIS_NSPAWN_MACHINE=${ALIS_NSPAWN_MACHINE:-"alis-test"}
ALIS_NSPAWN_USER=${ALIS_NSPAWN_USER:-"alis"}
ALIS_NSPAWN_WORKDIR=${ALIS_NSPAWN_WORKDIR:-"/home/${ALIS_NSPAWN_USER}/alis"}
ALIS_SKIP_REBOOT=${ALIS_SKIP_REBOOT:-1}
ALIS_SKIP_FULL_UPGRADE=${ALIS_SKIP_FULL_UPGRADE:-1}
ALIS_LOG_FILE=${ALIS_LOG_FILE:-"/tmp/alis.log"}
ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE=${ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE:-"/tmp/finalize-startup-entries.sh"}

if [ -z "${ALIS_NSPAWN_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_ROOTFS must point to an existing container rootfs" >&2
	exit 1
fi

if [ ! -d "${ALIS_NSPAWN_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_ROOTFS does not exist: ${ALIS_NSPAWN_ROOTFS}" >&2
	exit 1
fi

nspawn_args=(
	"--directory=${ALIS_NSPAWN_ROOTFS}"
	"--machine=${ALIS_NSPAWN_MACHINE}"
	"--bind-ro=${REPO_ROOT}:/mnt/alis-src"
)

systemd-nspawn "${nspawn_args[@]}" \
	runuser -u "${ALIS_NSPAWN_USER}" -- \
	/usr/bin/env \
	ALIS_COMPONENTS="${ALIS_COMPONENTS:-}" \
	ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE="${ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE}" \
	ALIS_LOG_FILE="${ALIS_LOG_FILE}" \
	ALIS_NSPAWN_WORKDIR="${ALIS_NSPAWN_WORKDIR}" \
	ALIS_SKIP_FULL_UPGRADE="${ALIS_SKIP_FULL_UPGRADE}" \
	ALIS_SKIP_REBOOT="${ALIS_SKIP_REBOOT}" \
	ALIS_TARGET_HARDWARES="${ALIS_TARGET_HARDWARES:-}" \
	/bin/bash /mnt/alis-src/tests/nspawn/inside_container_run.sh
