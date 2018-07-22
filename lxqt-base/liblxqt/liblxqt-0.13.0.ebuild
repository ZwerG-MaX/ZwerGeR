# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="http://lxqt.org/"

SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
KEYWORDS="amd64 x86"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

RDEPEND=">=dev-libs/libqtxdg-3.2.0
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	kde-frameworks/kwindowsystem:5[X]
	>=dev-util/lxqt-build-tools-0.5.0
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		tc-is-gcc && [[ $(gcc-version) < 4.8 ]] && \
		die 'The active compiler needs to be gcc 4.8 (or newer)'
	fi
}

src_configure() {
	local mycmakeargs=( -DPULL_TRANSLATIONS=OFF )
	cmake-utils_src_configure
}
