# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib rpm

DESCRIPTION="Base component of 1C ERP system"
HOMEPAGE="http://v8.1c.ru/"

MY_PV=$(ver_rs 3 '-')
MY_PN="1C_Enterprise83-common"

if [[ KEYWORDS == x86 ]] ; then
	MY_LIBDIR="i386"
elif [[ KEYWORDS == amd64 ]] ; then
	MY_LIBDIR="x86_64"
fi

SRC_URI="
	x86? ( ${MY_PN}-${MY_PV}.i386.rpm
	nls? ( ${MY_PN}-nls-${MY_PV}.i386.rpm ) )
	amd64? ( ${MY_PN}-${MY_PV}.x86_64.rpm
	nls? ( ${MY_PN}-nls-${MY_PV}.x86_64.rpm ) )
"

SLOT=$(ver_cut 1-2)
LICENSE="1CEnterprise_en"
KEYWORDS="amd64 x86"
RESTRICT="fetch strip"
IUSE="+nls"

RDEPEND="
	>=sys-libs/glibc-2.3
	>=dev-libs/icu-3.8.1-r1
"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

QA_TEXTRELS="opt/1C/v${SLOT}/${MY_LIBDIR}/backbas.so"
QA_EXECSTACK="opt/1C/v${SLOT}/${MY_LIBDIR}/backbas.so"

src_install() {
	dodir /opt
	mv "${WORKDIR}"/opt/* "${D}"/opt
}