#!/bin/bash

set -euo pipefail

ALIS_QCOW_DIR=${ALIS_QCOW_DIR:-"${HOME}/vms/alis"}
ALIS_QCOW_BASE=${ALIS_QCOW_BASE:-"${ALIS_QCOW_DIR}/base.qcow2"}
ALIS_QCOW_RUN=${ALIS_QCOW_RUN:-"${ALIS_QCOW_DIR}/run.qcow2"}

ALIS_QCOW_BASE_VM=${ALIS_QCOW_BASE_VM:-"alis-base"}
ALIS_QCOW_TEST_VM=${ALIS_QCOW_TEST_VM:-"alis-test"}

# libvirt connection URI.
# Default to per-user (`qemu:///session`) to avoid host filesystem permission issues
# when disk/ISO paths are under $HOME.
ALIS_LIBVIRT_URI=${ALIS_LIBVIRT_URI:-"qemu:///session"}

ALIS_QCOW_DISK_SIZE=${ALIS_QCOW_DISK_SIZE:-"80G"}
ALIS_QCOW_RAM_MB=${ALIS_QCOW_RAM_MB:-"8192"}
ALIS_QCOW_VCPUS=${ALIS_QCOW_VCPUS:-"4"}

# virt-install network spec.
# If unset, scripts choose a sane default based on ALIS_LIBVIRT_URI:
# - session: user-mode networking
# - system: libvirt default NAT network
ALIS_QCOW_NETWORK=${ALIS_QCOW_NETWORK:-""}

require_cmd() {
	local cmd=$1
	if ! command -v "${cmd}" >/dev/null 2>&1; then
		echo "Missing required command: ${cmd}" >&2
		exit 1
	fi
}

ensure_dir() {
	local dir=$1
	mkdir -p "${dir}"
}

refuse_if_exists() {
	local path=$1
	local what=$2
	if [ -e "${path}" ]; then
		echo "Refusing to overwrite existing ${what}: ${path}" >&2
		echo "Delete it first, or set ALIS_QCOW_FORCE=1." >&2
		exit 1
	fi
}

maybe_remove() {
	local path=$1
	if [ -e "${path}" ]; then
		rm -f "${path}"
	fi
}
