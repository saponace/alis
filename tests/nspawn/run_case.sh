#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." && pwd)
ALIS_NSPAWN_BASE_ROOTFS=${ALIS_NSPAWN_BASE_ROOTFS:-""}
ALIS_NSPAWN_MACHINE=${ALIS_NSPAWN_MACHINE:-"alis-test"}
ALIS_NSPAWN_USER=${ALIS_NSPAWN_USER:-"alis"}
ALIS_NSPAWN_WORKDIR=${ALIS_NSPAWN_WORKDIR:-"/home/${ALIS_NSPAWN_USER}/alis"}
ALIS_NSPAWN_RUN_ROOTFS=${ALIS_NSPAWN_RUN_ROOTFS:-""}
ALIS_NSPAWN_KEEP_RUN_ROOTFS=${ALIS_NSPAWN_KEEP_RUN_ROOTFS:-0}
ALIS_NSPAWN_PACMAN_CACHE_DIR=${ALIS_NSPAWN_PACMAN_CACHE_DIR:-"/var/cache/pacman/pkg"}
ALIS_NSPAWN_YAY_CACHE_DIR=${ALIS_NSPAWN_YAY_CACHE_DIR:-"/var/cache/alis-nspawn/yay"}
ALIS_SKIP_REBOOT=${ALIS_SKIP_REBOOT:-1}
ALIS_SKIP_FULL_UPGRADE=${ALIS_SKIP_FULL_UPGRADE:-1}
ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE=${ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE:-"/tmp/finalize-startup-entries.sh"}

if [ "$(id -u)" -ne 0 ]; then
	echo "Run tests/nspawn/run_case.sh as root (e.g. with sudo) so systemd-nspawn can start the container" >&2
	exit 1
fi

if [ -z "${ALIS_NSPAWN_BASE_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_BASE_ROOTFS must point to an existing container rootfs" >&2
	exit 1
fi

if [ ! -d "${ALIS_NSPAWN_BASE_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_BASE_ROOTFS does not exist: ${ALIS_NSPAWN_BASE_ROOTFS}" >&2
	exit 1
fi

CONTAINER_USER_IDS=$(awk -F: -v username="${ALIS_NSPAWN_USER}" '$1 == username { print $3 ":" $4 }' "${ALIS_NSPAWN_BASE_ROOTFS}/etc/passwd")

if [ -z "${CONTAINER_USER_IDS}" ]; then
	echo "Could not determine uid/gid for ${ALIS_NSPAWN_USER} in ${ALIS_NSPAWN_BASE_ROOTFS}" >&2
	exit 1
fi

if [ -z "${ALIS_NSPAWN_RUN_ROOTFS}" ]; then
	ALIS_NSPAWN_RUN_ROOTFS=$(mktemp -d --tmpdir alis-nspawn-rootfs.XXXXXX)
else
	if [[ "${ALIS_NSPAWN_RUN_ROOTFS}" != /* ]]; then
		echo "ALIS_NSPAWN_RUN_ROOTFS must be an absolute path: ${ALIS_NSPAWN_RUN_ROOTFS}" >&2
		exit 1
	fi
fi

cleanup() {
	if [ "${ALIS_NSPAWN_KEEP_RUN_ROOTFS}" = "1" ]; then
		echo "Keeping run rootfs at ${ALIS_NSPAWN_RUN_ROOTFS}"
	else
		# Extra safety: only delete directories we created.
		if [ -f "${ALIS_NSPAWN_RUN_ROOTFS}/.alis-nspawn-run-rootfs" ]; then
			rm -rf "${ALIS_NSPAWN_RUN_ROOTFS}"
		else
			echo "Refusing to delete ${ALIS_NSPAWN_RUN_ROOTFS}: missing .alis-nspawn-run-rootfs marker" >&2
		fi
	fi
}

trap cleanup EXIT

mkdir -p "${ALIS_NSPAWN_RUN_ROOTFS}"

base_rootfs_real=$(readlink -f "${ALIS_NSPAWN_BASE_ROOTFS}")
run_rootfs_real=$(readlink -f "${ALIS_NSPAWN_RUN_ROOTFS}")
if [ "${base_rootfs_real}" = "${run_rootfs_real}" ]; then
	echo "ALIS_NSPAWN_RUN_ROOTFS must not equal ALIS_NSPAWN_BASE_ROOTFS: ${ALIS_NSPAWN_RUN_ROOTFS}" >&2
	exit 1
fi

# Safety: refuse to use a non-empty run rootfs directory.
if [ -n "$(ls -A "${ALIS_NSPAWN_RUN_ROOTFS}" 2>/dev/null)" ]; then
	echo "Refusing to use non-empty ALIS_NSPAWN_RUN_ROOTFS: ${ALIS_NSPAWN_RUN_ROOTFS}" >&2
	echo "Delete it first, or choose a new ALIS_NSPAWN_RUN_ROOTFS." >&2
	exit 1
fi

touch "${ALIS_NSPAWN_RUN_ROOTFS}/.alis-nspawn-run-rootfs"

cp -a "${ALIS_NSPAWN_BASE_ROOTFS}/." "${ALIS_NSPAWN_RUN_ROOTFS}"
mkdir -p "${ALIS_NSPAWN_PACMAN_CACHE_DIR}"
mkdir -p "${ALIS_NSPAWN_YAY_CACHE_DIR}"
chown "${CONTAINER_USER_IDS}" "${ALIS_NSPAWN_YAY_CACHE_DIR}"
mkdir -p "${ALIS_NSPAWN_RUN_ROOTFS}/var/cache/pacman/pkg"
mkdir -p "${ALIS_NSPAWN_RUN_ROOTFS}/home/${ALIS_NSPAWN_USER}/.cache"
chown "${CONTAINER_USER_IDS}" "${ALIS_NSPAWN_RUN_ROOTFS}/home/${ALIS_NSPAWN_USER}/.cache"

nspawn_args=(
	"--directory=${ALIS_NSPAWN_RUN_ROOTFS}"
	"--machine=${ALIS_NSPAWN_MACHINE}"
	"--bind-ro=${REPO_ROOT}:/mnt/alis-src"
	"--bind=${ALIS_NSPAWN_PACMAN_CACHE_DIR}:/var/cache/pacman/pkg"
	"--bind=${ALIS_NSPAWN_YAY_CACHE_DIR}:/home/${ALIS_NSPAWN_USER}/.cache/yay"
)

if [ -r /run/systemd/resolve/resolv.conf ]; then
	nspawn_args+=("--bind-ro=/run/systemd/resolve/resolv.conf:/etc/resolv.conf")
elif [ -r /etc/resolv.conf ]; then
	nspawn_args+=("--bind-ro=/etc/resolv.conf:/etc/resolv.conf")
fi

systemd-nspawn "${nspawn_args[@]}" \
	runuser -u "${ALIS_NSPAWN_USER}" -- \
	/usr/bin/env \
	ALIS_COMPONENTS="${ALIS_COMPONENTS:-}" \
	ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE="${ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE}" \
	ALIS_NSPAWN_WORKDIR="${ALIS_NSPAWN_WORKDIR}" \
	ALIS_SKIP_FULL_UPGRADE="${ALIS_SKIP_FULL_UPGRADE}" \
	ALIS_SKIP_REBOOT="${ALIS_SKIP_REBOOT}" \
	ALIS_TARGET_HARDWARES="${ALIS_TARGET_HARDWARES:-}" \
	/bin/bash /mnt/alis-src/tests/nspawn/inside_container_run.sh
