add_lunch_combo aosp_janice-eng
add_lunch_combo aosp_janice-userdebug

__janice_init_tools()
{
	local n=
	
	for n in "$(dirname "${BASH_SOURCE[1]}")"/tools/* ; do
		[ -x "${n}" ] || continue
		alias janice-"$(basename "${n}")"="$(realpath "${n}")"
	done
}

__janice_init_tools
unset __janice_init_tools
