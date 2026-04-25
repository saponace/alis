# qcow2 + QEMU/KVM test workflow

This directory contains a reproducible workflow for testing `alis` in a real VM.

Goals:

- Boot into a fully functional system (GUI) like VirtualBox
- Reset VM state quickly between test runs (overlays)
- Avoid re-downloading packages between runs (shared pacman cache)

This uses:

- `qcow2` disk images (base + overlay)
- libvirt (`virsh`, `virt-install`) to manage the VM
- SPICE graphics (works well from `virt-manager`)

## Prereqs (host)

- CPU virtualization enabled (VT-x/AMD-V)
- `libvirtd` running and your user in the `kvm` + `libvirt` groups

Install tools (Arch/Manjaro):

```bash
sudo pacman -S --needed qemu-full libvirt virt-manager virt-viewer dnsmasq ovmf
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt,kvm "$USER"
```

Log out / log in after `usermod`.

## Environment variables

All scripts accept these variables:

- `ALIS_QCOW_DIR` (default: `$HOME/vms/alis`)
- `ALIS_QCOW_BASE` (default: `$ALIS_QCOW_DIR/base.qcow2`)
- `ALIS_QCOW_RUN` (default: `$ALIS_QCOW_DIR/run.qcow2`)
- `ALIS_QCOW_BASE_VM` (default: `alis-base`)
- `ALIS_QCOW_TEST_VM` (default: `alis-test`)
- `ALIS_QCOW_DISK_SIZE` (default: `80G`)
- `ALIS_QCOW_RAM_MB` (default: `8192`)
- `ALIS_QCOW_VCPUS` (default: `4`)
- `ALIS_ISO_PATH` (required for base install)
- `ALIS_LIBVIRT_URI` (default: `qemu:///session`)

## One-time: create base disk + install OS

1) Create the base disk:

```bash
./tests/qcow/create_base_disk.sh
```

2) Boot the installer ISO into the base disk:

```bash
ALIS_ISO_PATH=/path/to/your.iso ./tests/qcow/virt_install_base.sh
```

Note: If you switch to `ALIS_LIBVIRT_URI=qemu:///system`, make sure the hypervisor can access the ISO and qcow2 paths. Easiest is to keep VM images under `/var/lib/libvirt/images`.

This creates a VM definition named `alis-base` and boots it. Complete OS install inside the VM.

Recommended inside the guest (so tests are smooth):

```bash
sudo pacman -S --needed git base-devel openssh
sudo systemctl enable --now sshd
```

Shut down the VM when done.

## Per run: resettable overlay VM

Create/refresh the overlay disk:

```bash
./tests/qcow/create_overlay.sh
```

Create the test VM definition (first time only):

```bash
./tests/qcow/virt_install_overlay.sh
```

Start the test VM:

```bash
virsh start alis-test
```

Open it in a GUI:

- Use `virt-manager`, or:

```bash
virt-viewer --connect qemu:///system alis-test
```

Reset between runs:

```bash
virsh shutdown alis-test
./tests/qcow/reset_overlay.sh
virsh start alis-test
```

## Package cache reuse (optional but recommended)

To avoid re-downloading packages each run, create a host cache directory and attach it as a virtiofs filesystem.

Host setup:

```bash
sudo ./tests/qcow/setup_host_pacman_cache.sh
```

Then add a filesystem device to the VM (via `virt-manager`) mapping:

- Source: `/var/cache/alis-vm/pacman-pkg`
- Target/tag: `pacman_pkg`
- Driver: `virtiofs`

In the guest, mount it:

```bash
sudo mkdir -p /var/cache/pacman/pkg
sudo mount -t virtiofs pacman_pkg /var/cache/pacman/pkg
echo 'pacman_pkg /var/cache/pacman/pkg virtiofs defaults 0 0' | sudo tee -a /etc/fstab
```

Do that once in the base VM (so every overlay benefits).
