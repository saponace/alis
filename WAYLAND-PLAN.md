# Wayland Migration Plan

This branch is for a full Wayland migration of `alis`.

Branch:
- `feat/wayland-migration`

Current status:
- The first functional Wayland commit exists:
  - `1902e83 replace i3 stack with minimal sway session`
- It replaces the installer window-manager component with a minimal `sway` session.
- It is intentionally incomplete.
- It does not yet migrate launcher, notifications, idle/lock, status bar, monitor profiles, or display manager.

## User Preferences And Constraints

These preferences should be treated as active guidance for the rest of the branch work.

- Prefer a full Wayland migration on this branch, not a dual-backend (`x11` + `wayland`) architecture.
- Avoid overengineering fallback mechanisms inside the installer when a disposable VM is available.
- The migration should target `sway` as the compositor/window manager.
- The launcher choice is `wofi`.
- The display manager direction is `greetd`, but only after the manual `sway` session is known-good.
- Test in a VM first.
- The user intends to install once, then snapshot the VM, then repeatedly reset to that snapshot while validating each commit.
- Commits should be small, unitary, and testable.
- Preferred commit style is feature-by-feature, such as:
  - `replace i3 stack with minimal sway session`
  - `add wofi and desktop utilities`
  - `add swayidle and swaylock`
  - `add waybar`
  - `add kanshi`
  - `switch login to greetd`
- Keep the migration cumulative. Each commit should leave the branch in a coherent state for its scope.
- Avoid rewriting history in the future unless explicitly requested.
- Never force-push under any circumstance.
- Do not switch branches unless explicitly requested.
- When proposing host-system repair commands, explain clearly what they do before running them.
- Prefer direct, minimal commands over opaque compound commands when touching the host system.

## VM Testing Strategy

Planned VM workflow:

1. Use a `Manjaro Sway` ISO as the base install image for Wayland work.
2. Complete the OS install once.
3. Run the installer for the target commit.
4. Validate only that commit's scope.
5. If broken, fix the branch, reset the VM to the clean snapshot, and retry.
6. Only move to the next commit after the current commit is green.

Reasoning:
- This avoids repeated full installs and repeated dependency downloads.
- It removes the need for an in-installer X11 fallback path.
- It keeps the branch focused on the final target architecture.

## Commit Sequence

Target sequence from here:

1. `replace i3 stack with minimal sway session`
2. `add wofi and desktop utilities`
3. `add swayidle and swaylock`
4. `add waybar`
5. `add kanshi`
6. `switch login to greetd`
7. `polish portals and app compatibility`

Notes:
- The first commit exists already.
- `greetd` should come after the manual `sway` session is stable.
- `waybar` should be separate from the initial session commit.
- Display-manager risk should not be mixed into the earliest session bring-up work.

## Scope Of The First Commit

The current first commit should remain narrow:

- Replace the installer's i3-focused window-manager setup with a minimal `sway` setup.
- Reuse `alacritty` as the terminal.
- Keep startup manual from a TTY for now.
- Keep wallpaper support minimal.
- Do not add `wofi`, `waybar`, `greetd`, `swayidle`, `swaylock`, `kanshi`, or portal polish yet.

Expected first-commit validation:

- Log into a TTY.
- Run `sway`.
- Confirm that the session starts.
- Confirm that `Mod+Return` opens `alacritty`.
- Confirm that `Mod+b` opens Firefox.
- Confirm that basic tiling/workspace movement works.
- Confirm that exiting sway works cleanly.

## Known Incomplete Areas

The repo still contains X11 assumptions outside the first `sway` commit scope. These should be migrated deliberately in later commits instead of all at once.

Examples:
- [components/display/display.sh](/home/saponace/alis/components/display/display.sh) still uses `arandr`, `autorandr`, `redshift`, and `xset`.
- [components/hardware-drivers.sh](/home/saponace/alis/components/hardware-drivers.sh) still sets X11 keyboard state with `localectl set-x11-keymap` and `setxkbmap`.
- [components/hardware-specific/t550/t550.sh](/home/saponace/alis/components/hardware-specific/t550/t550.sh) still assumes `i3status`/`py3status`.
- Old i3/py3status/rofi/picom/lightdm config payloads still exist in the repo and can be removed or ignored gradually.

These are not reasons to widen the first commit. They are follow-up migration work.

## Technology Choices

Selected:
- Compositor/window manager: `sway`
- Launcher: `wofi`
- Status bar: `waybar`
- Notifications: likely `mako`
- Idle/lock: `swayidle` + `swaylock`
- Monitor profiles: `kanshi`
- Display manager: `greetd` with a simple greeter, likely `tuigreet`
- Wallpaper: `swaybg`
- Clipboard: `wl-clipboard`
- Screenshots: `grim` + `slurp`
- Portals: `xdg-desktop-portal` + wlroots-compatible backend

Rejected or deprioritized:
- Dual backend support inside this branch
- Keeping `LightDM` as part of the main migration path
- Using `rofi-wayland` instead of `wofi`
- Mixing `greetd` into the first working `sway` commit

## VirtualBox Note

Work was briefly interrupted by a host-side VirtualBox failure:
- `VERR_PDM_USB_NAME_CLASH`

Findings so far:
- The error affects multiple VMs, not just the new Sway VM.
- Installed `virtualbox`, kernel modules, and `vboxdrv` appear version-consistent on the host.
- Logs point at the Oracle Extension Pack USB plugin path, specifically `VBoxUsbCardReader`.
- Clearing the per-user VirtualBox component cache did not fix it.
- The most likely next host-side repair is temporarily disabling the Oracle Extension Pack and retrying VM startup.

This is host troubleshooting, not repo work, and should stay separate from the Wayland migration commits.
