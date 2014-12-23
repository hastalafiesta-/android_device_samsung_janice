# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/samsung/janice/janice.mk)

# Discard inherited values and use our own instead.
PRODUCT_NAME := full_janice
PRODUCT_DEVICE := janice
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_MODEL := GT-I9070
