# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils eutils

DESCRIPTION="GUI configuration tool for the compton X composite manager"
HOMEPAGE="https://github.com/lxqt/compton-conf"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="
	x11-misc/compton
	dev-util/lxqt-build-tools
	dev-qt/qtcore:5
	dev-libs/libconfig
"
RDEPEND="${DEPEND}"

#src_prepare(){
#	eapply "${FILESDIR}/desktop_entry.patch"
#	eapply_user
#}

src_configure() {
	local mycmakeargs=( -DPULL_TRANSLATIONS=OFF	)
	cmake-utils_src_configure
}
