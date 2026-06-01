# Running Windows EXE files and downloaded Linux files

Phoenix OS includes a small compatibility layer so the desktop can open common downloads without turning into a heavy distribution.

## Windows `.exe` and `.msi` files

Phoenix includes Wine. In the file manager, double-click a Windows `.exe` or `.msi` file to launch it with Wine, or run it from a terminal:

```bash
wine /path/to/program.exe
```

The first Wine launch creates a per-user Wine prefix under `~/.wine`. Not every Windows program will work in Wine, and large modern games or GPU-heavy applications are not a good fit for v86. Small 32-bit utilities are the best match.

## Linux downloads

Phoenix also includes helpers for common Linux files:

- `.rpm` opens a terminal and installs with `sudo zypper install`.
- `.AppImage`, `.run`, and `.sh` files are marked executable and launched.
- `.zip`, `.7z`, `.tar`, `.tar.gz`, `.tar.xz`, `.gz`, `.bz2`, and `.xz` archives extract into a new folder and open in the file manager.

The helper command is:

```bash
phoenix-open /path/to/file
```

## v86 notes

Wine works best in the persistent `v86-disk` image because the Wine prefix and installed Windows files can be saved on the emulated hard drive. Use at least `512` MB RAM in v86; more is better for Windows programs.
