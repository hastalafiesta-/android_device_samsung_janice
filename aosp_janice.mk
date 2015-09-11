# Full base telephony, modified.

PRODUCT_PACKAGES := \
    libfwdlockengine \
    WAPPushManager

PRODUCT_PROPERTY_OVERRIDES := \
    ro.com.android.dateformat=MM-dd-yyyy

PRODUCT_LOCALES := en_US
PRODUCT_AAPT_CONFIG := normal

# Use Material sounds.
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage13.mk)

$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/locales_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

# Inherit from those products. Most specific first.

$(call inherit-product, device/samsung/janice/janice.mk)

# Discard inherited values and use our own instead.

PRODUCT_NAME := aosp_janice
PRODUCT_DEVICE := janice
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_MODEL := GT-I9070

