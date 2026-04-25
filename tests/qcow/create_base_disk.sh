#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=tests/qcow/_common.sh
source "${SCRIPT_DIR}/_common.sh"

require_cmd qemu-img

ensure_dir "${ALIS_QCOW_DIR}"

if [ "${ALIS_QCOW_FORCE:-0}" != "1" ]; then
	refuse_if_exists "${ALIS_QCOW_BASE}" "base disk"
else
	maybe_remove "${ALIS_QCOW_BASE}"
fi

qemu-img create -f qcow2 "${ALIS_QCOW_BASE}" "${ALIS_QCOW_DISK_SIZE}"

echo "Created base disk: ${ALIS_QCOW_BASE}"
