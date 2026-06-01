# NoblePup-style desktop and hard-drive plan

Phoenix OS is configured to feel closer to NoblePup/Puppy Linux: a tiny panel/menu desktop, simple desktop icons, single-click file browsing, and a persistent hard-drive image for normal use. The goal is to stay responsive in v86 and on older 32-bit x86 machines by avoiding a heavyweight desktop environment.

## Desktop choices

- **Window manager:** JWM when the community package is available, with IceWM kept as a fallback so the image still boots to a desktop if that package source is unavailable.
- **Desktop/pinboard:** PCManFM runs in desktop mode to provide ROX-like desktop icons and simple single-click file browsing.
- **Display manager:** LightDM with the GTK greeter, configured to auto-login as the sample `phoenix` user for quick testing.
- **Graphics path:** BIOS/VESA/fbdev-friendly X11 with `nomodeset`, which is more predictable in v86 than accelerated graphics.
- **Default tools:** terminal, file manager, lightweight editor, Wine for Windows `.exe`/`.msi` files, archive tools, and basic networking/SSH tools.

This is not a byte-for-byte NoblePup clone: it stays openSUSE/KIWI based instead of Ubuntu/Debian Woof-CE based. But the user experience is now intentionally Puppy-like: tiny JWM-style desktop, desktop icons, fast file manager behavior, auto-login, Wine-based `.exe` launching, and a persistent disk image. It will also not be as tiny as KolibriOS because Phoenix is a Linux/openSUSE image with systemd, zypper, X11, and RPM packages.

## Hard-drive setup

Use the `v86-disk` profile when you want Phoenix to behave more like a normal installed OS with a persistent hard drive:

```bash
./scripts/build-v86-disk.sh
```

The output is:

```text
dist/phoenix-v86.img
```

On <https://copy.sh/v86/>, choose this file as the **Hard disk image**, give v86 at least `512` MB of memory for the desktop, and boot from the hard disk.

## ISO setup

Use the `v86-live` profile when you want a bootable CD-style ISO:

```bash
./scripts/build-v86-iso.sh
```

The output is:

```text
dist/phoenix-v86.iso
```

On <https://copy.sh/v86/>, choose this file as the **CD image** and set boot order to **CD / Hard Disk / Floppy**.

## Practical expectations

- Use the hard-disk image for regular testing; it avoids live-CD limitations and gives you persistent storage.
- Start with `512` MB RAM in v86 for the desktop. `256` MB may boot, but it is tight once X11 and apps are open.
- Keep apps small. Avoid adding KDE, GNOME, or browser-heavy defaults unless you are targeting newer hardware.
