# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils pax-utils rpm user

DESCRIPTION="Native linux client of 1C ERP system"
HOMEPAGE="http://v8.1c.ru/"

MY_PV=$(ver_rs 3 '-')
MY_PN="1C_Enterprise83-client"

SRC_URI="x86? ( ${MY_PN}-${MY_PV}.i386.rpm
	    nls? ( ${MY_PN}-nls-${MY_PV}.i386.rpm ) )
	amd64? ( ${MY_PN}-${MY_PV}.x86_64.rpm
	    nls? ( ${MY_PN}-nls-${MY_PV}.x86_64.rpm ) )"

SLOT=$(ver_cut 1-2)
LICENSE="1CEnterprise_en"
KEYWORDS="amd64 x86"
RESTRICT="fetch strip"
IUSE="+nls"

RDEPEND="
	~app-office/1C_Enterprise-common-${PV}:${SLOT}
	~app-office/1C_Enterprise-server-${PV}:${SLOT}
	>=dev-libs/icu-4.6
	net-libs/webkit-gtk:4
	app-crypt/mit-krb5
	media-gfx/imagemagick
	net-print/cups
	x11-libs/libSM
	dev-libs/atk
	x11-libs/libXxf86vm
	>=sys-libs/e2fsprogs-libs-1.41
	>=x11-libs/cairo-1.0
	sys-libs/glibc:2.2
	>=sys-devel/gcc-3.4
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf:2
	dev-libs/glib:2
	net-libs/libsoup:2.4
	sys-libs/zlib
"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /opt /usr
	mv "${WORKDIR}"/opt/* "${D}"/opt
	local res
	for res in 16 22 24 32 36 48 64 72 96 128 192 256; do
		for icon in 1cestart 1cv8 1cv8c 1cv8s; do
			newicon -s ${res} "${WORKDIR}/usr/share/icons/hicolor/${res}x${res}/apps/${icon}.png" "${icon}.png"
		done
	done


	domenu "${WORKDIR}"/usr/share/applications/{1cv8,1cv8c,1cestart}.desktop
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; fdo-mime_desktop_database_update; }
pkg_postrm() { gnome2_icon_cache_update; fdo-mime_desktop_database_update; }