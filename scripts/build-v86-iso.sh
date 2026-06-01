#!/usr/bin/env bash
# Build the Phoenix OS ISO that can be selected on the official v86 website.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
build_dir="${BUILD_DIR:-${repo_root}/build/v86}"
out_dir="${1:-${repo_root}/dist}"
out_iso="${out_dir}/phoenix-v86.iso"

if ! command -v kiwi-ng >/dev/null 2>&1; then
  cat >&2 <<'MSG'
kiwi-ng is required to build Phoenix OS.
Install KIWI NG on openSUSE, then rerun this script.
MSG
  exit 127
fi

mkdir -p "${build_dir}" "${out_dir}"

sudo kiwi-ng --profile v86-live --type iso system build \
  --description "${repo_root}" \
  --target-dir "${build_dir}"

iso_path="$(find "${build_dir}" -maxdepth 1 -type f -name '*.iso' -print | sort | tail -n 1)"
if [[ -z "${iso_path}" ]]; then
  echo "No ISO was produced in ${build_dir}" >&2
  exit 1
fi

cp -f "${iso_path}" "${out_iso}"
echo "Phoenix v86 ISO: ${out_iso}"
