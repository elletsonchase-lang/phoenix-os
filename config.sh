#!/bin/bash
# KIWI image customization for Phoenix OS.
set -euxo pipefail

# KIWI exposes helper metadata through these files during image creation.
# shellcheck disable=SC1091
[[ -f /.kconfig ]] && source /.kconfig
# shellcheck disable=SC1091
[[ -f /.profile ]] && source /.profile

echo "Configuring ${kiwi_iname:-Phoenix OS}..."

# Keep the live image small and avoid leaking host build-machine state.
rm -rf /var/cache/zypp/* /var/log/zypp/* /tmp/* /var/tmp/*

# Enable standard services useful for a small service-building base image.
systemctl enable wicked.service
systemctl enable sshd.service

# Boot straight into the lightweight IceWM desktop when the graphical stack is present.
# The display-manager alias is provided by the LightDM package included in config.xml.
systemctl set-default graphical.target
systemctl enable display-manager.service

# Allow the sample phoenix user to use sudo during early image testing.
cat > /etc/sudoers.d/phoenix <<'SUDOERS'
phoenix ALL=(ALL) ALL
SUDOERS
chmod 0440 /etc/sudoers.d/phoenix

# Refresh desktop and MIME caches so EXE/RPM/archive click handlers are visible.
command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database /usr/share/applications
command -v update-mime-database >/dev/null 2>&1 && update-mime-database /usr/share/mime
