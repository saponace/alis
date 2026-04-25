#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=tests/qcow/_common.sh
source "${SCRIPT_DIR}/_common.sh"

require_cmd qemu-img

if [ ! -f "${ALIS_QCOW_BASE}" ]; then
	echo "Base disk not found: ${ALIS_QCOW_BASE}" >&2
	echo "Run ./tests/qcow/create_base_disk.sh and install an OS first." >&2
	exit 1
fi

ensure_dir "${ALIS_QCOW_DIR}"

if [ "${ALIS_QCOW_FORCE:-0}" = "1" ]; then
	maybe_remove "${ALIS_QCOW_RUN}"
fi

if [ -e "${ALIS_QCOW_RUN}" ]; then
	echo "Overlay already exists: ${ALIS_QCOW_RUN}" >&2
	echo "Run ./tests/qcow/reset_overlay.sh to recreate it." >&2
	exit 1
fi

qemu-img create -f qcow2 -F qcow2 -b "${ALIS_QCOW_BASE}" "${ALIS_QCOW_RUN}"
echo "Created overlay disk: ${ALIS_QCOW_RUN}"
