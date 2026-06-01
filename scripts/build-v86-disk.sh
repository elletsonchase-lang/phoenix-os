#!/usr/bin/env bash
# Build a Phoenix OS raw hard-disk image for the official v86 website.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
build_dir="${BUILD_DIR:-${repo_root}/build/v86-disk}"
out_dir="${1:-${repo_root}/dist}"
out_img="${out_dir}/phoenix-v86.img"

if ! command -v kiwi-ng >/dev/null 2>&1; then
  cat >&2 <<'MSG'
kiwi-ng is required to build Phoenix OS.
Install KIWI NG on openSUSE, then rerun this script.
MSG
  exit 127
fi

mkdir -p "${build_dir}" "${out_dir}"

sudo kiwi-ng --profile v86-disk --type oem system build \
  --description "${repo_root}" \
  --target-dir "${build_dir}"

image_path="$(find "${build_dir}" -maxdepth 1 -type f \( -name '*.raw' -o -name '*.img' -o -name '*.qcow2' -o -name '*.raw.xz' -o -name '*.img.xz' \) -print | sort | tail -n 1)"
if [[ -z "${image_path}" ]]; then
  echo "No hard-disk image was produced in ${build_dir}" >&2
  exit 1
fi

case "${image_path}" in
  *.xz)
    xz -dc "${image_path}" > "${out_img}"
    ;;
  *)
    cp -f "${image_path}" "${out_img}"
    ;;
esac

echo "Phoenix v86 hard-disk image: ${out_img}"
