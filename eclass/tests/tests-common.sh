#!/bin/bash
# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

if ! source /lib/gentoo/functions.sh ; then
	echo "Missing functions.sh.  Please install sys-apps/gentoo-functions!" 1>&2
	exit 1
fi

export PORTAGE_BIN_PATH="$(ls -d /usr/lib/portage/py* | tail -n 1)"
[ -z "${PORTAGE_BIN_PATH}" ] && { echo "PORTAGE_BIN_PATH var empty"; exit 1; }

source "${PORTAGE_BIN_PATH}"/isolated-functions.sh || { echo "Error sourcing isolated-functions.sh"; exit 1; }


# Let overlays override this so they can add their own testsuites.
TESTS_ECLASS_SEARCH_PATHS=( .. )

inherit() {
	local e path
	for e in "$@" ; do
		for path in "${TESTS_ECLASS_SEARCH_PATHS[@]}" ; do
			local eclass=${path}/${e}.eclass
			if [[ -e "${eclass}" ]] ; then
				source "${eclass}"
				return 0
			fi
		done
	done
	die "could not find ${eclass}"
}
EXPORT_FUNCTIONS() { :; }

debug-print() {
	[[ ${#} -eq 0 ]] && return

	if [[ ${ECLASS_DEBUG_OUTPUT} == on ]]; then
		printf 'debug: %s\n' "${@}" >&2
	elif [[ -n ${ECLASS_DEBUG_OUTPUT} ]]; then
		printf 'debug: %s\n' "${@}" >> "${ECLASS_DEBUG_OUTPUT}"
	fi
}

debug-print-function() {
	debug-print "${1}, parameters: ${*:2}"
}

debug-print-section() {
	debug-print "now in section ${*}"
}
