#!/bin/bash

set -euo pipefail

ALIS_NSPAWN_BASE_ROOTFS=${ALIS_NSPAWN_BASE_ROOTFS:-""}
ALIS_NSPAWN_USER=${ALIS_NSPAWN_USER:-"alis"}
ALIS_NSPAWN_HOSTNAME=${ALIS_NSPAWN_HOSTNAME:-"alis-nspawn"}

if [ -z "${ALIS_NSPAWN_BASE_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_BASE_ROOTFS must point to the rootfs directory to create" >&2
	exit 1
fi

sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}"
sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/var/lib/pacman"
sudo mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d"

sudo cp /etc/pacman.conf "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.conf"
sudo cp /etc/pacman.d/mirrorlist "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/mirrorlist"
sudo cp /etc/resolv.conf "${ALIS_NSPAWN_BASE_ROOTFS}/etc/resolv.conf"

sudo pacman --root "${ALIS_NSPAWN_BASE_ROOTFS}" \
	--dbpath "${ALIS_NSPAWN_BASE_ROOTFS}/var/lib/pacman" \
	--cachedir /var/cache/pacman/pkg \
	--config /etc/pacman.conf \
	--noconfirm -Sy base base-devel git sudo systemd

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
