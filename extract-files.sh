#!/bin/bash
#
# Copyright (C) 2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required!
export DEVICE=james
export DEVICE_COMMON=msm8937-common
export VENDOR=motorola

export DEVICE_BRINGUP_YEAR=2019

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"

DEVICE_BLOB_ROOT="${LINEAGE_ROOT}/vendor/${VENDOR}/${DEVICE}"

sed -i "s/libgui/libwui/" "${DEVICE_BLOB_ROOT}/vendor/lib/libmot_gpu_mapper.so"
sed -i "s/libgui/libwui/" "${DEVICE_BLOB_ROOT}/vendor/lib/libmmcamera_vstab_module.so"
sed -i "s/libgui/libwui/" "${DEVICE_BLOB_ROOT}/vendor/lib/libjscore.so"
patchelf --remove-needed libstagefright.so "${DEVICE_BLOB_ROOT}/vendor/lib/libjscore.so"
