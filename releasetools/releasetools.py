def FullOTA_InstallEnd(info):
	info.script.AppendExtra('symlink("/system/lib/libjhead.so", "/system/lib/libhead.so");')
#	info.script.AppendExtra('run_program("/sbin/make_ext4fs", "/dev/block/mmcblk0p9");')
