# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JBIJ_PN_PRETTY='RubyMine'
JBIJ_URI="ruby/${JBIJ_PN_PRETTY}-${PV}"

inherit jetbrains-intellij

DESCRIPTION="${JBIJ_PN_PRETTY} is the most intelligent Ruby and Rails IDE"

JBIJ_DESKTOP_EXTRAS=(
	# "MimeType=text/x-php;text/html;" # MUST end with semicolon # TODO
)
