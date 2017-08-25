# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
inherit eutils git-2 qmake-utils

DESCRIPTION="Algorithm Flowchart Editor"
HOMEPAGE="http://zvlib.fatal.ru/"
EGIT_REPO_URI="https://github.com/viktor-zin/afce.git"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtxml:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
		dev-db/sqlite:3"

src_configure() {
	eqmake5 PREFIX="$D/usr" "${S}"/${PN}.pro
}
