# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg

DESCRIPTION="The downright luxurious Git client, for Windows, Mac & Linux"
HOMEPAGE="https://www.gitkraken.com"
SRC_URI="https://release.gitkraken.com/linux/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="gitkraken-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="dev-util/electron-bin:1.6
	net-libs/gnutls
	gnome-base/libgnome-keyring
	media-gfx/graphite2"

S="${WORKDIR}/gitkraken"

src_install() {
	newbin "${FILESDIR}"/gitkraken-launcher.sh gitkraken

	insinto /usr/libexec/gitkraken
	doins -r resources/app.asar{,.unpacked}
	scanelf -Xe "${ED%/}"/usr/libexec/gitkraken/app.asar.unpacked/node_modules/nodegit/build/Release/nodegit.node

	dosym libcurl.so.4 /usr/$(get_libdir)/libcurl-gnutls.so.4

	doicon -s 512 "${FILESDIR}"/icon/gitkraken.png
	make_desktop_entry gitkraken Gitkraken gitkraken Development
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
