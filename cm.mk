# Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := GT-I9070

# Boot animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/janice/full_janice.mk)

# CM Packages
PRODUCT_PACKAGES += \
    Stk \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := janice
PRODUCT_NAME := cm_janice
PRODUCT_BRAND := samsung
PRODUCT_MODEL := GT-I9070
PRODUCT_MANUFACTURER := samsung

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=GT-I9070 TARGET_DEVICE=janice
