# Device Tree for GT-I9070 (janice)

# Apply patches
./device/samsung/janice/patches/patch-apply.sh

# Setup environment
. build/envsetup.sh
lunch aosp_janice-userdebug

# Start build
make -jx otapackage

x varies according to your PC's threads
