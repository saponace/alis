#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=tests/qcow/_common.sh
source "${SCRIPT_DIR}/_common.sh"

require_cmd virt-install
require_cmd virsh

ALIS_ISO_PATH=${ALIS_ISO_PATH:-""}
if [ -z "${ALIS_ISO_PATH}" ]; then
	echo "ALIS_ISO_PATH is required (path to installer ISO)" >&2
	exit 1
fi

if [ ! -f "${ALIS_ISO_PATH}" ]; then
	echo "ISO not found: ${ALIS_ISO_PATH}" >&2
	exit 1
fi

if [ ! -f "${ALIS_QCOW_BASE}" ]; then
	echo "Base disk not found: ${ALIS_QCOW_BASE}" >&2
	echo "Run ./tests/qcow/create_base_disk.sh first." >&2
	exit 1
fi

if virsh dominfo "${ALIS_QCOW_BASE_VM}" >/dev/null 2>&1; then
	echo "VM already exists: ${ALIS_QCOW_BASE_VM}" >&2
	echo "Use virt-manager/virsh to manage it, or undefine it if you want to recreate." >&2
	exit 1
fi

network_spec=${ALIS_QCOW_NETWORK}
if [ -z "${network_spec}" ]; then
	if [ "${ALIS_LIBVIRT_URI}" = "qemu:///session" ]; then
		network_spec="user,model=virtio"
	else
		network_spec="network=default,model=virtio"
	fi
fi

virt-install \
	--connect "${ALIS_LIBVIRT_URI}" \
	--name "${ALIS_QCOW_BASE_VM}" \
	--memory "${ALIS_QCOW_RAM_MB}" \
	--vcpus "${ALIS_QCOW_VCPUS}" \
	--cpu host-model \
	--disk "path=${ALIS_QCOW_BASE},format=qcow2,bus=virtio" \
	--cdrom "${ALIS_ISO_PATH}" \
	--boot uefi \
	--network "${network_spec}" \
	--graphics spice \
	--video virtio \
	--osinfo detect=on,require=off

echo "Created and booted VM: ${ALIS_QCOW_BASE_VM}"
