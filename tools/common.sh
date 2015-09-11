# common.sh by @nieltg


# +----
# + Text Formatting
# +----

text_delim ()
{
	# ( delim, text... ) => in format: "text1 delim text2 delim textN..."

	local txt=
	local delim="$1"
	shift
	while (( "$#" )); do
		txt="${txt}${1}${delim}"
		shift
	done

	if [ "${#delim}" -gt 0 ] ; then
		echo "${txt:0: -${#delim}}"
	else
		echo "${txt}"
	fi
}

text_delim_comma ()
{
	# ( text... ) => in format: "text1, text2, textN..."

	echo "$(text_delim ", " "$@")"
}

text_plural ()
{
	# ( n, singular, [plural] ) => in format, ex: "3 apples", "1 boat"

	if [ "${1}" -gt 1 ] ; then
		local plu="${3}"
		if [ -z "${plu}" ] ; then # Guess the plural form of ${2}.
			if   [ "${2: -1}" == "x"  ] ; then plu="${2}es"
			elif [ "${2: -1}" == "h"  ] ; then plu="${2}es"
			elif [ "${2: -1}" == "s"  ] ; then plu="${2}es"
			elif [ "${2: -1}" == "f"  ] ; then plu="${2:0:-1}ves"
			elif [ "${2: -2}" == "fe" ] ; then plu="${2:0:-2}ves"
			else plu="${2}s" ; fi
		fi
		echo "${1} ${plu}"
	else
		echo "${1} ${2}"
	fi
}

text_summary_bracket ()
{
	# ( summary, desc. ) => in format: "summary (desc.)"

	if [ -n "${2}" ] ; then
		echo "${1} (${2})"
	else
		echo "${1}"
	fi
}


# +----
# + Low-Level Write
# +----

# Concept:
# - pa_wri_* are made for log_* to write to stdout/stderr
# - Any other subsystems should use log_* for logging mechanism

pa_wri_e ()
{
	# ( text... ) => nul; put text to stderr

	echo "$@" > /dev/stderr
}

pa_wri_e_n ()
{
	# ( msg... ) => nul; write to stderr with app name

	pa_wri_e "${PA_LOG_APP}:" "$@"
}

pa_wri_o ()
{
	# ( text... ) => nul; put text to stdout

	echo "$@" > /dev/stdout
}

pa_wri_o_n ()
{
	# ( msg... ) => nul; write to stdout with app name

	pa_wri_o "${PA_LOG_APP}:" "$@"
}


# +----
# + Logging Interface
# +----

log_init ()
{
	# ( app_name ) => nul; print header

	[ -n "${1}" ] || app_assert

	PA_LOG_APP="${1}"

	pa_wri_e "${PA_LOG_APP} by @nieltg"
	pa_wri_e
}

log_w ()
{
	# ( msg ) => nul; log warning message
	
	pa_wri_e_n "${@}"
}

log_e ()
{
	# ( msg ) => nul; log error message
	
	pa_wri_e_n "${@}"
}

log_assert ()
{
	# ( [n_skip] ) => nul; log call trace

	local n_skip="${1}" ; [ -z "${n_skip}" ] && n_skip="0"
	[ -z "${PA_LOG_APP}" ] && PA_LOG_APP=$(basename "${BASH_SOURCE[0]}")

	local n_src="${BASH_SOURCE[1+${n_skip}]}"
	local n_row="${BASH_LINENO[${n_skip}]}"

	pa_wri_e
	pa_wri_e_n $(tail -n "+${n_row}" "${n_src}" | head -n 1)
	pa_wri_e_n "assertion error encountered!"

	pa_wri_e
	pa_wri_e "Call trace:"

	local i="${n_skip}"
	while caller "${i}"; do ((i++)); done | awk '{
		printf "  #%-2d %s (%s:%d)\n", ++i, $2, $3, $1
	}' >&2

	pa_wri_e
}

log_paths ()
{
	# ( nul ) => nul; log build top & patch directory
	
	pa_wri_e "Build top: ${ANDROID_BUILD_TOP}"
	pa_wri_e "Patch dir: ${PA_ENG_PATCH_DIR}"
	pa_wri_e
}

log_progress_prepare ()
{
	# ( work_count ) => nul; prepare for logging tasks

	PA_LOG_TASK="${1}"
	PA_LOG_TASK_DONE="0"
	PA_LOG_TASK_PASS="0"
}

log_progress_summary ()
{
	# ( nul ) => nul; show summary & reset

	local p="$(text_plural "${PA_LOG_TASK}" task)"

	pa_wri_e
	pa_wri_e "${PA_LOG_TASK_PASS} of ${p} done."
	pa_wri_e

	PA_LOG_TASK="0"
	PA_LOG_TASK_DONE="0"
	PA_LOG_TASK_PASS="0"
}

log_progress_start ()
{
	# ( msg ) => nul; print current progress

	# TODO: print msg & let it be replaced (do '\r' & clear line first)
	true
}

log_progress_fini ()
{
	# ( status, msg ) => nul; print progress summary

	(( PA_LOG_TASK_DONE++ ))
	[ "${1}" -eq "0" ] && (( PA_LOG_TASK_PASS++ ))

	pa_wri_e "[${PA_LOG_TASK_DONE}/${PA_LOG_TASK}] ${2}"
}


# +----
# + Patches Engine
# +----

# Patches format: [BASE]/[NAME].patch
# [BASE]: base repo, ex: "frameworks_av" => "frameworks/av" ('_' => '/')
# [NAME]: patch cap, ex: "Audio_Patches" => "Audio Patches" ('_' => ' ')

patch_init ()
{
	# ( nul ) => nul; initalize patch engine

	PA_ENG_PATCH_DIR="${1}"

	# TODO: remove ${ANDROID_BUILD_TOP} checking since it's not important here
	# ${ANDROID_BUILD_TOP} is used by 'patch', but it's not used while looping
	# TODO: pa_ext_buildtop

	if [ -z "${ANDROID_BUILD_TOP}" ] ; then
		log_e "\${ANDROID_BUILD_TOP} is not defined"
		log_e "build/envsetup.sh should be executed first!"
		return 1
	fi

	log_paths
}

patch_parse_repo ()
{
	# ( patch_file ) => base repo; in bracket: [BASE]/NAME.patch

	local d="$(dirname ${1})"
	local b="$(basename ${d})"
	echo "${b//_//}"
}

patch_parse_title ()
{
	# ( patch_file ) => patch title; in bracket: BASE/[NAME].patch

	local b="$(basename ${1} .patch)"
	echo "${b//_/ }"
}

patch_patch_loop ()
{
	# ( func ( patch_file ) ) => nul; iterate through patches

	[ -n "${PA_ENG_PATCH_DIR}" ] || app_assert
	[ -n "$(type -t "${1}")" ] || app_assert
	# TODO: pa_ext_callable

	local n_objs=( "${PA_ENG_PATCH_DIR}"/*/*.patch )

	log_progress_prepare "${#n_objs[@]}"

	for ob in "${n_objs[@]}" ; do
		"${1}" "${ob}"
	done

	log_progress_summary
}

patch_repo_loop ()
{
	# ( func ( base_repo ) ) => nul; iterate through repos

	[ -n "${PA_ENG_PATCH_DIR}" ] || app_assert
	[ -n "$(type -t "${1}")" ] || app_assert
	# TODO: pa_ext_callable

	local -a n_repo

	mapfile -t n_repo < <(
		for pa in "${PA_ENG_PATCH_DIR}"/*/*.patch ; do
			echo $(patch_parse_repo "${pa}")
		done | uniq
	)

	log_progress_prepare "${#n_repo[@]}"

	for ta in "${n_repo[@]}" ; do
		"${1}" "${ta}"
	done

	log_progress_summary
}


# +----
# + Basic Application
# +----

app_assert ()
{
	# ( nul ) => nul; log assertion error & exit

	log_assert 1
	exit 1
}

app_fatal ()
{
	# ( [msg...] ) => nul; log assertion error & exit

	[ "${#}" -gt 0 ] && log_e "${@}"
	exit 1
}

app_init ()
{
	# ( args_func, args... ) => nul; process arguments & initalize

	# TODO: argument parser here!

	local args_func="$1"
	shift

	#while (( "$#" )); do
	#	case "$1" in
	#		-h|--help)
	#			;;
	#	esac
	#done

	# TODO: remove there log_init & patch_init refs
	# Apps should call them by theirself, ex: patcher call patch_init
	# Subsystem should also call 'init's, ex: patcher_init call log_init

	log_init "$(basename "${BASH_SOURCE[1]}")"
	[ "$?" -ne 0 ] && app_fatal

	patch_init "$(dirname "${BASH_SOURCE[1]}")/../patches"
	[ "$?" -ne 0 ] && app_fatal
}

