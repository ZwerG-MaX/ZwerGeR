# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rpm.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: RPM eclass
# @DESCRIPTION:

if [ -z "${_RPM_ECLASS}" ] ; then

case "${EAPI:-0}" in
    6) ;;
    *) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


DEPEND_A_OLD=(
	# rpmoffset
	app-arch/rpm2targz
	# cpio
	app-arch/cpio
	# decompressors
	# xz, bzip2, gz
)
DEPEND_A=(
	'app-arch/libarchive[bzip2,lzma,zlib]'
)
DEPEND="${DEPEND_A[@]}"
unset DEPEND_A


rpm_unpack_old() {
	debug-print-function "${FUNCNAME}" "$@"
	local f_in="${1}"
	local d_out="${2:-"${PWD}"}"
	shift 2

	[[ -z "${f_in}" ]] && die "f_in is empty"
	[[ -f "${f_in}" ]] || die "f_in='${f_in}' doesn't exist"
	[[ -d "${d_out}" ]] || die "d_out='${d_out}' doesn't exist"

	local rpm_info=( $( rpmoffset -v < "${f_in}" ) ) || die
	(( ${#rpm_info[*]} == 2 )) || die "rpm_info wrong element count"

	local rpm_compression="${rpm_info[0]}" rpm_offset="${rpm_info[1]}"
	[[ -z "${rpm_compression}" || -z "${rpm_offset}" ]] && die "Parsing rpm_info went wrong"

	local decompressor="${rpm_compression}"
	debug-print "${FUNCNAME}: decompressor='${decompressor}'"

	local dd=( dd if="${f_in}" ibs="${rpm_offset}" skip=1 status=none )
	local decompress=( ${decompressor} -dc  )
	local cpio=( cpio --extract
		--directory="${d_out}"
		--preserve-modification-time --make-directories --unconditional
		--no-absolute-filenames --quiet
		--nonmatching )

	"${dd[@]}" | "${decompress[@]}" | "${cpio[@]}"
	assert "RPM extraction went wrong for '$(basename "$(dirname "${f_in}")")/$(basename "${f_in}")'"
}

rpm_unpack() {
	debug-print-function "${FUNCNAME}" "$@"
	local f_in="${1}"
	local d_out="${2:-"${PWD}"}"
	shift 2

	local bsdtar=( bsdtar --extract
		--no-same-owner -o
		--file "${f_in}"
		--directory "${d_out}"
	)
	echo "${bsdtar[@]}"
	"${bsdtar[@]}" || die
}


EXPORT_FUNCTIONS src_unpack


rpm_src_unpack() {
	local a
	for a in ${A} ; do
		case ${a} in
		*.rpm)
			echo ">>> Unpacking ${a} to ${PWD}"
			rpm_unpack "${DISTDIR}/${a}" "${PWD}"
			;;
		*)		unpack "${a}" ;;
		esac
	done
}


_RPM_ECLASS=1
fi
