# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils flag-o-matic multilib rpm versionator

DESCRIPTION="Base component of 1C ERP system"
HOMEPAGE="http://v8.1c.ru/"

MY_PV="$(replace_version_separator 3 '-' )"
MY_PN="1C_Enterprise83-common"
if use x86 ; then
    MY_LIBDIR="i386"
elif use amd64 ; then
    MY_LIBDIR="x86_64"
fi

SRC_URI="x86? ( ${MY_PN}-${MY_PV}.i386.rpm
	    nls? ( ${MY_PN}-nls-${MY_PV}.i386.rpm ) )
	amd64? ( ${MY_PN}-${MY_PV}.x86_64.rpm
	    nls? ( ${MY_PN}-nls-${MY_PV}.x86_64.rpm ) )"

SLOT="$(get_version_component_range 1-2)"
LICENSE="1CEnterprise_en"
KEYWORDS=""
RESTRICT="fetch strip"
IUSE="+nls"

RDEPEND=">=sys-libs/glibc-2.3
	>=dev-libs/icu-3.8.1-r1"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

QA_TEXTRELS="opt/1C/v${SLOT}/${MY_LIBDIR}/backbas.so"
QA_EXECSTACK="opt/1C/v${SLOT}/${MY_LIBDIR}/backbas.so"

src_install() {
	dodir /opt
	mv "${WORKDIR}"/opt/* "${D}"/opt
}
