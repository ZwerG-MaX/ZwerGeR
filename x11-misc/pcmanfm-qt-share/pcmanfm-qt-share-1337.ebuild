# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="PCManFM-QT custom action to share folder using Samba"
HOMEPAGE="https://redcorelinux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-fs/samba"
RDEPEND="${DEPEND}"

S="${FILESDIR}"

src_install() {
	dodir "/usr/share/file-manager/actions" || die
	insinto "/usr/share/file-manager/actions" || die
	doins -r "${S}/"* || die
}
