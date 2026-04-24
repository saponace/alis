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

- `tests/nspawn/create_rootfs.sh`: host-side bootstrap script that creates a rootfs and test user for `systemd-nspawn`
- `tests/nspawn/run_case.sh`: host-side wrapper that launches `systemd-nspawn`
- `tests/nspawn/test.sh`: convenience wrapper that creates the base rootfs if needed and then runs a disposable test case
- `tests/nspawn/inside_container_run.sh`: container-side entrypoint that copies the repo into the container and runs `configure-system.sh`

## Current workflow

`run_case.sh` expects a pre-existing rootfs and launches a disposable test run against it.

Required environment variables:

- `ALIS_NSPAWN_BASE_ROOTFS=/path/to/rootfs`: clean base rootfs used to create disposable test runs

- `ALIS_NSPAWN_MACHINE=alis-test`: machine name passed to `systemd-nspawn`
- `ALIS_NSPAWN_USER=alis`: non-root container user that runs the installer
- `ALIS_NSPAWN_WORKDIR=/home/alis/alis`: writable repo path inside the container
- `ALIS_NSPAWN_RUN_ROOTFS=/path/to/run-rootfs`: explicit path for the disposable rootfs copy
- `ALIS_NSPAWN_KEEP_RUN_ROOTFS=1`: keep the disposable rootfs after the run for manual inspection
- `ALIS_TARGET_HARDWARES="t550 desktop"`: pass hardware-specific CLI arguments to `configure-system.sh`

## Bootstrapping a rootfs

Create a rootfs and the default `alis` test user with:

```bash
ALIS_NSPAWN_BASE_ROOTFS=/var/lib/machines/alis ./tests/nspawn/create_rootfs.sh
```

This script:

- creates the rootfs directory
- copies `pacman` config and DNS resolver config into it
- installs a minimal package set needed to run `alis`
- creates a passwordless-sudo test user inside the rootfs

## One-shot test command

If you want a single command that ensures the base rootfs exists and then runs a disposable test case, use:

```bash
sudo ALIS_NSPAWN_BASE_ROOTFS="$HOME/.local/share/alis/nspawn/base" \
  ALIS_COMPONENTS="package-manager system" \
  ./tests/nspawn/test.sh
```

This will create the base rootfs on first use and reuse it on later runs. If `ALIS_NSPAWN_BASE_ROOTFS` is unset, `tests/nspawn/test.sh` defaults to `$HOME/.local/share/alis/nspawn/base`.

Example:

```bash
sudo ALIS_NSPAWN_BASE_ROOTFS=/var/lib/machines/alis \
  ALIS_COMPONENTS="package-manager system" \
  ./tests/nspawn/run_case.sh
```

Each run starts from a disposable copy of the base rootfs, so the base remains clean across runs. The repo is mounted read-only at `/mnt/alis-src`, copied into the container workdir, and then executed from there as the non-root container user so the installer behaves more like a normal workstation setup.
