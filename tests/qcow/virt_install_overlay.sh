#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=tests/qcow/_common.sh
source "${SCRIPT_DIR}/_common.sh"

require_cmd virt-install
require_cmd virsh

if [ ! -f "${ALIS_QCOW_RUN}" ]; then
	echo "Overlay disk not found: ${ALIS_QCOW_RUN}" >&2
	echo "Run ./tests/qcow/create_overlay.sh first." >&2
	exit 1
fi

if virsh dominfo "${ALIS_QCOW_TEST_VM}" >/dev/null 2>&1; then
	echo "VM already exists: ${ALIS_QCOW_TEST_VM}" >&2
	echo "If you want to recreate it: virsh undefine ${ALIS_QCOW_TEST_VM} --nvram" >&2
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
	--name "${ALIS_QCOW_TEST_VM}" \
	--memory "${ALIS_QCOW_RAM_MB}" \
	--vcpus "${ALIS_QCOW_VCPUS}" \
	--cpu host-model \
	--disk "path=${ALIS_QCOW_RUN},format=qcow2,bus=virtio" \
	--import \
	--boot uefi \
	--network "${network_spec}" \
	--graphics spice \
	--video virtio \
	--osinfo detect=on,require=off \
	--noautoconsole

echo "Created VM definition: ${ALIS_QCOW_TEST_VM}"
echo "Start it with: virsh start ${ALIS_QCOW_TEST_VM}"
