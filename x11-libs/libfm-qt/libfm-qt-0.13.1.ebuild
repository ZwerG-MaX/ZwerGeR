# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="Core library of PCManFM-Qt"
HOMEPAGE="http://lxqt.org/"

LICENSE="LGPL-2.1+"
SLOT="0/3"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	>=lxde-base/menu-cache-0.4.1
	>=x11-libs/libfm-1.2.5:=
	x11-libs/libxcb:=
	!<x11-misc/pcmanfm-qt-0.13.0
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.5.0
	>=lxqt-base/liblxqt-0.13.0
	media-libs/libexif
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DPULL_TRANSLATIONS=OFF
	)

	cmake-utils_src_configure
}