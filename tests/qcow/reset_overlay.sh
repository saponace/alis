#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=tests/qcow/_common.sh
source "${SCRIPT_DIR}/_common.sh"

require_cmd virsh

state=$(virsh domstate "${ALIS_QCOW_TEST_VM}" 2>/dev/null || true)
case "${state}" in
	running|paused|"in shutdown")
		echo "VM '${ALIS_QCOW_TEST_VM}' is ${state}; shut it down before resetting overlay." >&2
		exit 1
		;;
esac

maybe_remove "${ALIS_QCOW_RUN}"
ALIS_QCOW_FORCE=1 "${SCRIPT_DIR}/create_overlay.sh" >/dev/null

echo "Reset overlay disk: ${ALIS_QCOW_RUN}"
