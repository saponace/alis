#!/bin/bash

set -euo pipefail

ALIS_NSPAWN_BASE_ROOTFS=${ALIS_NSPAWN_BASE_ROOTFS:-""}
ALIS_NSPAWN_USER=${ALIS_NSPAWN_USER:-"alis"}
ALIS_NSPAWN_HOSTNAME=${ALIS_NSPAWN_HOSTNAME:-"alis-nspawn"}
ROOTFS_PACKAGES="base base-devel git sudo systemd iptables"

ensure_device_node() {
	local path=$1
	local type=$2
	local major=$3
	local minor=$4

	if [ ! -e "${path}" ]; then
		sudo mknod -m 666 "${path}" "${type}" "${major}" "${minor}"
	fi
}

if [ -z "${ALIS_NSPAWN_BASE_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_BASE_ROOTFS must point to the rootfs directory to create" >&2
	exit 1
fi

sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}"
sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/var/lib/pacman"
sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d"
sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/dev/pts"

sudo cp /etc/pacman.conf "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.conf"
sudo cp /etc/pacman.d/mirrorlist "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/mirrorlist"
sudo cp /etc/resolv.conf "${ALIS_NSPAWN_BASE_ROOTFS}/etc/resolv.conf"

ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/null" c 1 3
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/zero" c 1 5
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/full" c 1 7
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/random" c 1 8
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/urandom" c 1 9
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/tty" c 5 0
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/pts/ptmx" c 5 2

if [ ! -L "${ALIS_NSPAWN_BASE_ROOTFS}/dev/ptmx" ]; then
	sudo ln -sfn pts/ptmx "${ALIS_NSPAWN_BASE_ROOTFS}/dev/ptmx"
fi

sudo env LANG=C.UTF-8 LC_ALL=C.UTF-8 pacman --root "${ALIS_NSPAWN_BASE_ROOTFS}" \
	--dbpath "${ALIS_NSPAWN_BASE_ROOTFS}/var/lib/pacman" \
	--cachedir /var/cache/pacman/pkg \
	--config /etc/pacman.conf \
	--needed --noconfirm -Sy ${ROOTFS_PACKAGES}

sudo systemd-nspawn -D "${ALIS_NSPAWN_BASE_ROOTFS}" --as-pid2 /bin/bash -lc "pacman-key --init && pacman-key --populate archlinux manjaro"

sudo systemd-firstboot \
	--root="${ALIS_NSPAWN_BASE_ROOTFS}" \
	--hostname="${ALIS_NSPAWN_HOSTNAME}" \
	--locale=C.UTF-8 \
	--timezone=UTC \
	--setup-machine-id

if ! sudo grep -q "^${ALIS_NSPAWN_USER}:" "${ALIS_NSPAWN_BASE_ROOTFS}/etc/passwd"; then
	sudo useradd --root "${ALIS_NSPAWN_BASE_ROOTFS}" --create-home --user-group --groups wheel --shell /bin/bash "${ALIS_NSPAWN_USER}"
fi

sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/etc/sudoers.d"
printf '%s\n' "${ALIS_NSPAWN_USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "${ALIS_NSPAWN_BASE_ROOTFS}/etc/sudoers.d/10-${ALIS_NSPAWN_USER}" >/dev/null
sudo chmod 440 "${ALIS_NSPAWN_BASE_ROOTFS}/etc/sudoers.d/10-${ALIS_NSPAWN_USER}"

echo "Created nspawn rootfs at ${ALIS_NSPAWN_BASE_ROOTFS}"
echo "Container user: ${ALIS_NSPAWN_USER}"
