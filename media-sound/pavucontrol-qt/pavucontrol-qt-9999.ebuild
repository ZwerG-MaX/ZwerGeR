# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Qt port of pavucontrol"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="doc"

CDEPEND="
	dev-libs/glib:2
	>=lxqt-base/liblxqt-0.10
	media-sound/pulseaudio[glib]
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
"
DEPEND="${CDEPEND}
	>=dev-util/lxqt-build-tools-0.4.0
	dev-qt/linguist-tools:5
	virtual/pkgconfig
	x11-misc/xdg-user-dirs
"
RDEPEND="${CDEPEND}"

#src_prepare() {
#	default
#
#	# https://github.com/lxde/pavucontrol-qt/issues/31
#	sed -e 's|"changes-prevent"|"changes-prevent-symbolic"|' -i src/*.ui || die
#
#	cmake-utils_src_prepare
#}

src_configure() {
	local mycmakeargs=( -DPULL_TRANSLATIONS=OFF )
	cmake-utils_src_configure
}