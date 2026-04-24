#!/bin/bash

set -euo pipefail

ALIS_NSPAWN_BASE_ROOTFS=${ALIS_NSPAWN_BASE_ROOTFS:-""}
ALIS_NSPAWN_USER=${ALIS_NSPAWN_USER:-"alis"}
ALIS_NSPAWN_HOSTNAME=${ALIS_NSPAWN_HOSTNAME:-"alis-nspawn"}
ALIS_NSPAWN_PACMAN_CACHE_DIR=${ALIS_NSPAWN_PACMAN_CACHE_DIR:-"/var/cache/pacman/pkg"}
ROOTFS_PACKAGES="base base-devel git sudo systemd iptables archlinux-keyring"

if [ "$(id -u)" -ne 0 ]; then
	echo "Run tests/nspawn/create_rootfs.sh as root (e.g. with sudo)" >&2
	exit 1
fi

ensure_device_node() {
	local path=$1
	local type=$2
	local major=$3
	local minor=$4

	if [ ! -e "${path}" ]; then
		mknod -m 666 "${path}" "${type}" "${major}" "${minor}"
	fi
}

copy_resolv_conf() {
	local dest=$1

	# If the host uses systemd-resolved stub (127.0.0.53), prefer the upstream
	# resolv.conf so DNS works inside containers.
	if [ -r /etc/resolv.conf ] && grep -qE '^nameserver[[:space:]]+127\.0\.0\.53([[:space:]]+|$)' /etc/resolv.conf; then
		if [ -r /run/systemd/resolve/resolv.conf ]; then
			cp /run/systemd/resolve/resolv.conf "${dest}"
			return 0
		fi
	fi

	if [ -r /etc/resolv.conf ]; then
		cp /etc/resolv.conf "${dest}"
		return 0
	fi

	cat >"${dest}" <<'EOF'
nameserver 1.1.1.1
nameserver 8.8.8.8
EOF
}

if [ -z "${ALIS_NSPAWN_BASE_ROOTFS}" ]; then
	echo "ALIS_NSPAWN_BASE_ROOTFS must point to the rootfs directory to create" >&2
	exit 1
fi

mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}"
mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/var/lib/pacman"
mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d"
mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/gnupg"
mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/dev/pts"

# gpg expects this to be private.
chmod 700 "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/gnupg"

mkdir -p "${ALIS_NSPAWN_PACMAN_CACHE_DIR}"

cp /etc/pacman.conf "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.conf"
cp /etc/pacman.d/mirrorlist "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/mirrorlist"
copy_resolv_conf "${ALIS_NSPAWN_BASE_ROOTFS}/etc/resolv.conf"

ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/null" c 1 3
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/zero" c 1 5
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/full" c 1 7
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/random" c 1 8
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/urandom" c 1 9
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/tty" c 5 0
ensure_device_node "${ALIS_NSPAWN_BASE_ROOTFS}/dev/pts/ptmx" c 5 2

if [ ! -L "${ALIS_NSPAWN_BASE_ROOTFS}/dev/ptmx" ]; then
	ln -sfn pts/ptmx "${ALIS_NSPAWN_BASE_ROOTFS}/dev/ptmx"
fi


# Initialize a pacman keyring inside the rootfs so pacman can verify packages.
pacman-key --gpgdir "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/gnupg" --init
keyrings=()
if compgen -G "/usr/share/pacman/keyrings/*.gpg" >/dev/null; then
	for keyring_gpg in /usr/share/pacman/keyrings/*.gpg; do
		keyring_name=$(basename "${keyring_gpg}" .gpg)
		case "${keyring_name}" in
			*-trusted|*-revoked) continue ;;
		esac
		keyrings+=("${keyring_name}")
	done
fi

if [ "${#keyrings[@]}" -eq 0 ]; then
	keyrings=(archlinux)
fi

for keyring_name in "${keyrings[@]}"; do
	pacman-key --gpgdir "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/gnupg" --populate "${keyring_name}"
done

env LANG=C.UTF-8 LC_ALL=C.UTF-8 pacman --root "${ALIS_NSPAWN_BASE_ROOTFS}" \
	--dbpath "${ALIS_NSPAWN_BASE_ROOTFS}/var/lib/pacman" \
	--gpgdir "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.d/gnupg" \
	--cachedir "${ALIS_NSPAWN_PACMAN_CACHE_DIR}" \
	--config "${ALIS_NSPAWN_BASE_ROOTFS}/etc/pacman.conf" \
	--needed --noconfirm -Sy ${ROOTFS_PACKAGES}


systemd-firstboot \
	--root="${ALIS_NSPAWN_BASE_ROOTFS}" \
	--hostname="${ALIS_NSPAWN_HOSTNAME}" \
	--locale=C.UTF-8 \
	--timezone=UTC \
	--setup-machine-id

if ! grep -q "^${ALIS_NSPAWN_USER}:" "${ALIS_NSPAWN_BASE_ROOTFS}/etc/passwd"; then
	useradd --root "${ALIS_NSPAWN_BASE_ROOTFS}" --create-home --user-group --groups wheel --shell /bin/bash "${ALIS_NSPAWN_USER}"
fi

mkdir -p "${ALIS_NSPAWN_BASE_ROOTFS}/etc/sudoers.d"
printf '%s\n' "${ALIS_NSPAWN_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >"${ALIS_NSPAWN_BASE_ROOTFS}/etc/sudoers.d/10-${ALIS_NSPAWN_USER}"
chmod 440 "${ALIS_NSPAWN_BASE_ROOTFS}/etc/sudoers.d/10-${ALIS_NSPAWN_USER}"

echo "Created nspawn rootfs at ${ALIS_NSPAWN_BASE_ROOTFS}"
echo "Container user: ${ALIS_NSPAWN_USER}"
