# Copyright 1999-2016 Gentoo Foundation
# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: vcs-snapshot.eclass
# @MAINTAINER:
# dev.rindeal+gentoo-overlay@gmail.com
# @BLURB: support eclass for unpacking VCS snapshot tarballs
# @DESCRIPTION:
# This eclass provides a convenience src_unpack() which does unpack all
# the tarballs in SRC_URI to locations matching their (local) names,
# discarding the original parent directory.
#
# The typical use case are VCS snapshots, coming from bitbucket
# and similar services. They have hash appended to the directory name
# which makes extracting them a painful experience. But if you just use
# a SRC_URI arrow to rename it (which you're likely have to do anyway),
# vcs-snapshot will just extract it into a matching directory.
#
# Please note that this eclass handles only tarballs (.tar, .tar.gz,
# .tar.bz2 & .tar.xz). For any other file format (or suffix) it will
# fall back to regular unpack. Support for additional formats may be
# added at some point so please keep your SRC_URIs clean.
#
# Note: this eclass is no longer needed with the new-style 'archive'
# GitHub URLs. They have sane directory names and stable contents,
# so you should really prefer them.
#
# @EXAMPLE:
#
# @CODE
# EAPI=6
# inherit vcs-snapshot
#
# SRC_URI="https://github.com/example/${PN}/tarball/v${PV} -> ${P}.tar.gz
# 	https://github.com/example/${PN}-otherstuff/tarball/v${PV} -> ${P}-otherstuff.tar.gz"
# @CODE
#
# and however the tarballs were originally packed, all files will appear
# in ${WORKDIR}/${P} and ${WORKDIR}/${P}-otherstuff respectively.

if [ -z "${_VCS_SNAPSHOT_ECLASS}" ] ; then

case ${EAPI:-0} in
	5|6) ;;
	*) die "vcs-snapshot.eclass API in EAPI ${EAPI} not yet established."
esac


# @ECLASS-VARIABLE: VCS_SNAPSHOT_DESTDIR_TMPL
# @DEFAULT: @WORKDIR@/@AN@
# @DESCRIPTION:
# Name of the destdir. May include template vars.
: ${VCS_SNAPSHOT_DESTDIR_TMPL:="@WORKDIR@/@AN@"}


_vcs-snapshot_get_destdir() {
	local template="${1:-"${VCS_SNAPSHOT_DESTDIR_TMPL}"}"
	local v vars=( $(printf '%s\n' "${template}" | grep -Po "@.*?@" | tr -d '@') )

	for v in "${vars[@]}" ; do
		[ -v "${v}" ] || die "Variable '${v}' is not defined, but was used in a template"
		template="${template//"@${v}@"/${!v}}"
	done

	printf "%s\n" "${template}"
}


EXPORT_FUNCTIONS src_unpack


# @FUNCTION: vcs-snapshot_src_unpack
# @DESCRIPTION:
# Extract all the archives from ${A}. The .tar, .tar.gz, .tar.bz2
# and .tar.xz archives will be unpacked to directories matching their
# local names. Other archive types will be passed down to regular
# unpack.
vcs-snapshot_src_unpack() {
	debug-print-function ${FUNCNAME}

	local f

	for f in ${A} ; do
		case "${f}" in
			*.tar|*.tar.gz|*.tar.bz2|*.tar.xz)
				local AN="${f%.tar*}"

				local destdir="$(_vcs-snapshot_get_destdir)"

				debug-print "${FUNCNAME}: unpacking ${f} to ${destdir}"

				# TODO: check whether the directory structure inside is
				# fine? i.e. if the tarball has actually a parent dir.
				mkdir -p "${destdir}" || die
				tar --extract --file="${DISTDIR}/${f}" --directory="${destdir}" \
					--strip-components=1  || die
				;;
			*)
				debug-print "${FUNCNAME}: falling back to unpack() for ${f}"

				# fall back to the default method
				unpack "${f}"
				;;
		esac
	done
}

_VCS_SNAPSHOT_ECLASS=1
fi
