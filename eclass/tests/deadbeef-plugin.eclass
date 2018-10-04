# Copyright 2017 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: deadbeef-plugin.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: Eclass for deadbeef plugins
# @DESCRIPTION:

if [ -z "${_DEADBEEF_PLUGIN_ECLASS}" ] ; then

case "${EAPI:-0}" in
    6) ;;
    *) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


ddb_plugin_get_insdir() {
	echo "/usr/$(get_libdir)/deadbeef"
}

ddb_plugin_newins() {
	(
		exeinto "$(ddb_plugin_get_insdir)"
		newexe "${1}" "${2}"
	) || die
}

ddb_plugin_doins() {
	for p in "${@}" ; do
		ddb_plugin_newins "${p}" "${p##*/}"
	done
}


_DEADBEEF_PLUGIN_ECLASS=1
fi
