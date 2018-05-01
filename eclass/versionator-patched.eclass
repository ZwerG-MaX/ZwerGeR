# Copyright 2017 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: versionator-patched.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: <SHORT_DESCRIPTION>
# @DESCRIPTION:


case "${EAPI:-0}" in
    5|6) ;;
    *) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac

inherit rindeal


inherit versionator


_rindeal:hooks:save version_compare

version_compare() {
	if (( $# == 2 )) ; then
		_rindeal:hooks:call_orig version_compare "${@}"
	elif (( $# == 3 )) ; then
		_rindeal:hooks:call_orig version_compare "${1}" "${3}"
		local code=$?
		case "${2}" in
			"<") (( code == 1 )) ;;
			">") (( code == 3 )) ;;
			"==") (( code == 2 )) ;;
			*) die ;;
		esac
		return
	else
		die
	fi
}
