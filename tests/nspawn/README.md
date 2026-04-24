# `systemd-nspawn` test harness

This directory contains tooling and documentation for running `alis` inside a disposable `systemd-nspawn` container.

## Goals

- Validate installer flow without rebooting a real machine
- Exercise selected components in isolation
- Keep test-only behavior out of the normal install path

## Installer flags useful for test runs

The installer supports the following environment variables:

- `ALIS_SKIP_REBOOT=1`: do not reboot at the end of the run
- `ALIS_SKIP_FULL_UPGRADE=1`: skip `pacman -Syy` and `pacman -Syu`
- `ALIS_LOG_FILE=/path/to/logfile`: write installer output to a custom log file
- `ALIS_FINALIZE_STARTUP_ENTRIES_TEMP_FILE=/path/to/file`: use a custom temporary file for `finalize-startup` entries
- `ALIS_COMPONENTS="component-a component-b"`: run only the specified components, in the specified order

## Current status

The installer now exposes the controls needed for a container-based test harness.

The first harness scripts are:

- `tests/nspawn/run_case.sh`: host-side wrapper that launches `systemd-nspawn`
- `tests/nspawn/inside_container_run.sh`: container-side entrypoint that copies the repo into the container and runs `configure-system.sh`

## Current workflow

`run_case.sh` expects a pre-existing rootfs and launches a disposable test run against it.

Required environment variables:

- `ALIS_NSPAWN_ROOTFS=/path/to/rootfs`: container root filesystem used by `systemd-nspawn`

Optional environment variables:

- `ALIS_NSPAWN_MACHINE=alis-test`: machine name passed to `systemd-nspawn`
- `ALIS_NSPAWN_WORKDIR=/opt/alis`: writable repo path inside the container
- `ALIS_TARGET_HARDWARES="t550 desktop"`: pass hardware-specific CLI arguments to `configure-system.sh`

Example:

```bash
sudo ALIS_NSPAWN_ROOTFS=/var/lib/machines/alis \
  ALIS_COMPONENTS="package-manager system" \
  ./tests/nspawn/run_case.sh
```

The repo is mounted read-only at `/mnt/alis-src`, copied into the container workdir, and then executed from there so the container can write local artifacts such as `manual-configuration-instructions.txt`.
