#
# Copyright (C) 2012 The Android Open-Source Project
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

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

# Our devices are HDPI
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072 \
    ro.zygote.disable_gl_preload=1 \
    ro.bq.gpu_to_cpu_unsupported=1 \
    debug.sf.hw=1 \
    debug.hwui.render_dirty_regions=false

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Wifi
PRODUCT_PACKAGES += \
    libnetcmdiface \
    wpa_supplicant\
    Launcher3 \
    Terminal
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)

# Audio
PRODUCT_PACKAGES += \
    audio.usb.default \
    audio.a2dp.default \
    libaudioutils \
    libtinyalsa

# U8500 Hardware
$(call inherit-product, hardware/u8500/u8500.mk)

# USB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp \
    persist.service.adb.enable=1

#ART
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-flags=--no-watch-dog 

# Charger Prebuilt (temporary solution for lollipop)
# Use prebuilt charger and images from KitKat
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/charger/charger:root/sbin/charger \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_0.png:root/res/images/charger/battery_0.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_1.png:root/res/images/charger/battery_1.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_2.png:root/res/images/charger/battery_2.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_3.png:root/res/images/charger/battery_3.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_4.png:root/res/images/charger/battery_4.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_5.png:root/res/images/charger/battery_5.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_charge.png:root/res/images/charger/battery_charge.png \
    $(LOCAL_PATH)/prebuilt/charger/images/battery_fail.png:root/res/images/charger/battery_fail.png \

# Misc Packages
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory \
    SamsungServiceMode \
    Torch

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# F2FS
PRODUCT_PACKAGES += \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# Live Wallpapers
PRODUCT_PACKAGES += \
    librs_jni

# Dalvik VM config for 768MB RAM devices
PRODUCT_TAGS += dalvik.gc.type-precise

# Include blobs
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/system,system) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/root,root)

# Use the non-open-source parts, if they're present
include vendor/samsung/janice/vendor-common.mk

# == BEGIN LOCAL CONFIG ==

# For better compatibility with ROMs (like Slim, PAC)
$(call inherit-product, vendor/samsung/janice/janice/janice-vendor-blobs.mk)
    
# Wi-Fi test
PRODUCT_PACKAGES += \
libwpa_client \
hostapd \
dhcpcd.conf
