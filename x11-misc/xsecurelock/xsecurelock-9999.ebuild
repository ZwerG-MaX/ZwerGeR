# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="X11 screen lock utility with security in mind"
HOMEPAGE="https://github.com/google/xsecurelock"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/${PN}.git"
	EGIT_BOOTSTRAP=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/google/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="Apache-2.0"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXScrnSaver
"

DEPEND="${RDEPEND}"

src_prepare() {
	autoreconf -i
}

src_configure() {
	local myeconfargs=(
			--with-pam-service-name=SERVICE-NAME
			--prefix=/usr
	)
#	autotools_src_configure
}

#src_compile() {
#	autotools_src_compile
#}

#src_install() {
#	autotools_src_install
#}