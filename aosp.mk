# Release name
PRODUCT_RELEASE_NAME := GT-I9070

# Boot animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

# Inherit some common AOSP stuff.
$(call inherit-product, vendor/aosp/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/janice/aosp_janice.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := aosp_janice
PRODUCT_DEVICE := janice
PRODUCT_BRAND := samsung
PRODUCT_MODEL := GT-I9070
PRODUCT_MANUFACTURER := samsung

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=GT-I9070 TARGET_DEVICE=janice
