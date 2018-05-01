# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qt-pro-formatter.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: Format Qt project files (.pro) for easier sed-ing and grep-ing
# @DESCRIPTION:

if [ -z "${_QT_PRO_FORMATTER_ECLASS}" ] ; then


case "${EAPI:-0}" in
    6) ;;
    *) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


# gawk-4.1+ for inplace support
DEPEND=">=sys-apps/gawk-4.1"


format_qt_pro() {
	debug-print-function "${FUNCNAME}" "${@}"
	local files=( "${@}" )

	# check variable type
	[[ "$(declare -p qt_pro_awk_opts 2>/dev/null)" == "declare --"* ]] && die "qt_pro_awk_opts must be an array"
	# set default value
	[[ "$(declare -p qt_pro_awk_opts 2>/dev/null)" == "declare -a"* ]] || local qt_pro_awk_opts=( -i inplace )

	gawk "${qt_pro_awk_opts[@]}" --file=<( cat <<'_EOF_'
		BEGIN {
 			# The name of the variable in .pro file with a multiline value.
			# Restricted to `[A-Z_]+`.
			varname = ""
			in_breaked_line = 0
		}

		{
			# dos2unix
			gsub("\r", "")

			if ( in_breaked_line ) {
				# Do not process comments and print them unformatted.
				# Qt .pro files support comments in the middle of the breaked line.
				if ( match($0, "^[ \t]*#") != 0 ) {
					print
					next
				}

				# Now try to parse the line.
				# a[1] = line
				# a[2] = last char
				if ( match($0, "(.*)(.)$", a) == 0 ) {
					# If we get here, the line is completely empty (`^$`)
					in_breaked_line = 0
					print
					next
				}

				# Check whether we're still in a breaked statement.
				if ( a[2] != "\\" )
					in_breaked_line = 0

				printf "%s %c= %s\n",varname,sign,( in_breaked_line ? a[1] : $0 )
				next
			}

			# Try to parse the line. This is the core regex.
			# a[1] = variable name
			# a[2] = sign of the assignment
			# a[3] = first value of the multiline statement (without the trailing `\`)
			if ( match($0, "^[ \t]*([A-Z0-9_]*)[ \t]*([+-]?)=(.*)\\\\$", a) != 0 ) {
				# We're on the first line of a breaked statement.

				in_breaked_line = 1
				varname = a[1]

				printf "%s %c= %s\n",varname,a[2],a[3]

				# Default sign is `+`.
				# First line is printed even with no sign.
				sign = ( length(a[2]) == 0 ? "+" : a[2] )
			} else {
				# if not the first line of a breaked statement

				print
			}
		}
_EOF_
	) -- "${files[@]}" || die
}


_QT_PRO_FORMATTER_ECLASS=1
fi
