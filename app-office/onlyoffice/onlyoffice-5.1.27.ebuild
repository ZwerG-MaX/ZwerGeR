# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator rpm font

# Описываем программу
DESCRIPTION="onlyoffice is an office productivity suite"
HOMEPAGE="http://www.onlyoffice.com/"

KEYWORDS="~amd64"

# Указываем откуда брать пакет
SRC_URI="
	amd64? ( http://download.${PN}.com/install/desktop/editors/linux/${PN}-desktopeditors-x86_64.rpm -> ${P}-x86_64.rpm )
	"

SLOT="4"
RESTRICT="strip mirror"
LICENSE="AGPL-3"
IUSE=""

# Описываем зависимости
DEPEND="
	app-arch/rpm
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
	x11-libs/libxcb
	media-fonts/dejavu
	media-fonts/liberation-fonts
	>=app-office/libreoffice-6.0.2.1
	x11-libs/libX11
	x11-libs/libXScrnSaver
	net-misc/curl
	dev-libs/boost
	x11-libs/gtkglext"

# Распаковка пакета:
src_unpack () {
	rpm_src_unpack ${A}
	cd "${S}"
}

# Устанавливаем пакет:
src_install () {
	cp -vR "${S}"/* "${D}"/
}
