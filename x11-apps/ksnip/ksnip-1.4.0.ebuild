# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="Screenshot tool inspired by Windows Snipping Tool and made with Qt for Linux"
HOMEPAGE="https://github.com/DamirPorobic/ksnip"
SRC_URI="https://github.com/DamirPorobic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +qt5"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	   sed -i CMakeLists.txt -e 's:DESTINATION /bin:DESTINATION /usr/bin:' || die
}

