# Device Tree for GT-I8160 (codina)

I assume you have been familiar with CyanogenMod ROM development since this device tree is still buggy and I'm accepting pull requests... :D

Notes & issues I've encountered:

- InCallUI is shown very late & the Settings app is laggy.
- The recorded video is green, but the audio is recorded well.
- Flashlight is slow since it use camera interface. (should use sysfs interface)

## Step 1: Local Manifests & Sync

These are repositories I use. You can put this file on `.repo/local_manifests/codina.xml` or any name you want to use.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
	
	<!-- kernels & bootables -->
	<project path="kernel/codina/chrono" name="Dhoine/Chrono_Kernel" revision="stable" />

        <!-- recovery -->
        <remove-project name="CyanogenMod/android_bootable_recovery" />
        <project name="ChronoMonochrome/bootable_recovery" path="bootable/recovery" remote="github" revision="lp5.1" />
	<!-- cm11 base -->
	<project path="vendor/samsung/u8500-common" name="Dhoine/android_vendor_samsung_u8500-common" revision="cm-11.0" />
	
	<!-- cm12 custom -->
	<project path="device/samsung/codina" name="Dhoine/android_device_samsung_codina" />
	<project path="hardware/u8500" name="nieltg/android_hardware_u8500" />
	
</manifest>
```

## Step 2: Preparation

Some repositories must be patched before building. I've provided a script to do that. You can execute these commands on your build root.

You also should check `rootdir/variants/current` symlink in the device tree. Point it to default if you don't want to build sdboot variant which explanation you can read [here](https://github.com/nieltg/codina-initramfs-sdboot).

```bash
. build/envsetup.sh ; export USE_CCACHE=1
device/samsung/codina/patches/patch.sh
```

## Step 3: Compile

Like usual, there is nothing special here. On my system, it tooks about 4-5 hours to get a full build.

```bash
lunch cm_codina-eng
time mka bacon
```

## Step 4: Modify Zip

This device tree products flashable zip with invalid `boot.img` which is not the kernel. You must change it with raw kernel which is found at `out/target/product/codina/kernel`. Rename it to `boot.img` and put it back to the zip.

For sdboot build (and you have installed sdboot kernel), you can remove `boot.img` and its flashing routine in `update-script` to prevent flashing same kernel again and again. You also can remove things are match with this pattern: `, \"capabilities\", (.*), \"selabel\", \"(.*)\"` to prevent flashing errors if you are using older CWM like me.

Then, you can __backup__ & flash the zip. __You do it all at your own risk!__

