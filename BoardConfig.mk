#
# Copyright (C) 2012 The Android Open-Source Project
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/janice

TARGET_SPECIFIC_HEADER_PATH := device/samsung/janice/include
PRODUCT_VENDOR_KERNEL_HEADERS := $(LOCAL_PATH)/kernel-headers
TARGET_OTA_ASSERT_DEVICE := janice,i9070,GT-I9070

# Board
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_NO_SEPARATE_RECOVERY := true
TARGET_BOOTLOADER_BOARD_NAME := montblanc

# Partitions
BOARD_NAND_PAGE_SIZE := 4096
BOARD_NAND_SPARE_SIZE := 128
BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 641728512
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648

# Platform 
TARGET_SOC := u8500
BOARD_USES_STE_HARDWARE := true
BOARD_USES_STE_SAMSUNG_HARDWARE := true
TARGET_BOARD_PLATFORM := montblanc
COMMON_GLOBAL_CFLAGS += -DSTE_HARDWARE -DSTE_SAMSUNG_HARDWARE

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_SMP := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
ARCH_ARM_HAVE_NEON := true
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp

# Graphics
USE_OPENGL_RENDERER := true
BOARD_EGL_WORKAROUND_BUG_10194508 := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
COMMON_GLOBAL_CFLAGS += -DFORCE_SCREENSHOT_CPU_PATH -DWORKAROUND_BUG_10194508
BOARD_EGL_CFG := $(LOCAL_PATH)/configs/egl.cfg

# Wifi
BOARD_WLAN_DEVICE                := bcmdhd
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/dhd.ko"
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA          := "/system/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP           := "/system/etc/wifi/bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/system/etc/wifi/bcmdhd_p2p.bin"
WIFI_DRIVER_MODULE_NAME          := "dhd"
WIFI_DRIVER_MODULE_ARG           := "firmware_path=/system/etc/wifi/bcmdhd_sta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
WIFI_DRIVER_MODULE_AP_ARG        := "firmware_path=/system/etc/wifi/bcmdhd_apsta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
BOARD_LEGACY_NL80211_STA_EVENTS  := true
BOARD_NO_APSME_ATTR              := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := $(LOCAL_PATH)/configs/bluetooth/vnd_u8500.txt

# RIL
BOARD_RIL_CLASS := ../../../device/samsung/janice/configs/ril


# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_LEGACY_ALSA_AUDIO := true
BOARD_HAVE_PRE_KITKAT_AUDIO_POLICY_BLOB := true
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true
COMMON_GLOBAL_CFLAGS += -DMR0_AUDIO_BLOB -DMR1_AUDIO_BLOB -DBOARD_CANT_REALLOCATE_OMX_BUFFERS
USE_LEGACY_AUDIO_POLICY := 1

# Enable WEBGL in WebKit
ENABLE_WEBGL := true

# Vold
BOARD_VOLD_MAX_PARTITIONS := 25
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/musb-ux500.0/musb-hdrc/gadget/lun%d/file"

# Dex Pre-opt
WITH_DEXPREOPT := true

# Charging mode
BOARD_LPM_BOOT_ARGUMENT_NAME := lpm_boot
BOARD_LPM_BOOT_ARGUMENT_VALUE := 1

# SELinux
BOARD_SEPOLICY_DIRS := $(BOARD_SEPOLICY_DIRS) \
    $(LOCAL_PATH)/sepolicy

BOARD_SEPOLICY_UNION += \
    device.te \
    file.te \
    rild.te \
    drmserver.te \
    ueventd.te \
    domain.te \
    file_contexts \
    wpa_supplicant.te \
    vold.te

# Delete the line below when SELinux is enabled on all devices
COMMON_GLOBAL_CFLAGS += -DRECOVERY_CANT_USE_CONFIG_EXT4_FS_XATTR

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/u8500
TARGET_KERNEL_CONFIG := janice_defconfig
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x40000000
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/janice/shbootimg.mk
BOARD_KERNEL_CMDLINE := "androidboot.selinux=permissive"
TARGET_PROVIDES_ENVIRON_RC := true
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/fstab.samsungjanice
BOARD_CANT_BUILD_RECOVERY_FROM_BOOT_PATCH := true

# TWRP flags
DEVICE_RESOLUTION := 480x800
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_HAS_NO_RECOVERY_PARTITION := true
TW_FLASH_FROM_STORAGE := true
TW_INTERNAL_STORAGE_PATH := "/storage/sdcard0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard0"
TW_EXTERNAL_STORAGE_PATH := "/storage/sdcard1"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard1"
TW_INCLUDE_JB_CRYPTO := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/mmcblk0p5"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "noatime,nosuid,nodev,discard,noauto_da_alloc,journal_async_commit,errors=panic wait,check"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "/efs/metadata"
TW_INCLUDE_FUSE_EXFAT := true
TW_BOARD_CUSTOM_GRAPHICS := ../../../device/samsung/janice/recovery/twrp-graphics.c
TW_BRIGHTNESS_PATH := /sys/class/backlight/panel/brightness
TW_MAX_BRIGHTNESS := 255
TW_NO_USB_STORAGE := true
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_THEME := portrait_mdpi

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab \
    $(LOCAL_PATH)/recovery/recovery.fstab:recovery/root/etc/recovery.fstab

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(LOCAL_PATH)/releasetools

# Misc
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL -DREFRESH_RATE=60
BOARD_USES_LEGACY_MMAP := true
TARGET_ENABLE_NON_PIE_SUPPORT := true
BOARD_USES_LEGACY_ACQUIRE_WVM := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/configs/bluetooth/include

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

# Vibrator
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/samsung/janice/vibrator/vibrator.c

# Hardware tunables (device parts replacement)
BOARD_HARDWARE_CLASS := device/samsung/janice/cmhw

# Disable legacy sensors using because janice has gyro
BOARD_USE_LEGACY_SENSORS_FUSION := false
