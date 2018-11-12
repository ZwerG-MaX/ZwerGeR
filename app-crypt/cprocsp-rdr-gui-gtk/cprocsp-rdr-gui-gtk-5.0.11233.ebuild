# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cryptopro

DESCRIPTION="GUI components for CryptoPro CSP readers."

IUSE=""
SLOT="0"

KEYWORDS="-* ~amd64 ~x86"

RDEPEND="
	app-crypt/lsb-cprocsp-rdr
	x11-libs/gtk+:2
"
CRYPTOPRO_REGISTER_LIBS=(
	librdrrndmbio_gui_gtk.so
	libgcpui.so
	libgcpuifkc.so
)

CRYPTOPRO_UNSET_SECTIONS=(
	'\config\Random\bio_gui'
)

pkg_postinst() {
	cryptopro_pkg_postinst

	cryptopro_add_ini '\config\Random\bio_gui' string DLL librdrrndmbio_gui_gtk.so
	cryptopro_add_hardware rndm bio_gui "rndm GUI GTK+-2" "" 4
}

pkg_prerm() {
	cryptopro_remove_hardware rndm bio_gui
	cryptopro_pkg_prerm
}
