# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/lxde/qtermwidget"
SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${DEPEND}
	dev-util/lxqt-build-tools
"

RDEPEND="${DEPEND}"
PATCHES=( "${FILESDIR}/${P}-nofetch.patch" )