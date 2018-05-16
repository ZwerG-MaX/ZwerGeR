# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A tool for creating and managing Heroku apps from the command line"
HOMEPAGE="https://devcenter.heroku.com/articles/heroku-cli"
BASE_URI="https://cli-assets.heroku.com/${PN}-v${PV}"
SRC_URI="${BASE_URI}/${PN}-v${PV}-linux-x64.tar.gz -> ${P}-x64.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+git"

DEPEND="
	git? ( dev-vcs/git )
	>=net-libs/nodejs-8.11.1
"
RDEPEND="${DEPEND}"

pkg_setup(){
#	use amd64 && ARCH="x64"
#	use x86 && ARCH="x86"
	S="${WORKDIR}/${PN}"
}

src_install(){
	insinto /opt/${PN}
	doins -r *
	fperms +x /opt/${PN}/bin/${PN//-cli}
	fperms +x /opt/${PN}/bin/node
	insinto /usr/share/licenses/${PN}
	doins LICENSE
	dosym /opt/${PN}/bin/${PN//-cli} /usr/bin/${PN//-cli}
	dosym /opt/${PN}/bin/${PN//-cli} /usr/bin/${PN}
}
