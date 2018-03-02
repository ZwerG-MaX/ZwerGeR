# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

DESCRIPTION="Distributed, highly scalable platform providing robust telecom services"
HOMEPAGE="https://www.2600hz.org/"
SRC_URI="https://github.com/2600Hz/kazoo.git"
LICENSE="MPL-1.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pdf"

DEPEND="
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	dev-libs/libxslt
	sys-libs/zlib
	dev-libs/openssl:*
	net-misc/curl
	sys-libs/ncurses:5
	dev-vcs/git
	dev-libs/expat
	pdf? ( app-text/htmldoc )"

RDEPEND="${DEPEND}
	dev-lang/erlang"
# https://docs.2600hz.com/dev/doc/installation/     
#cd /opt
#git clone https://github.com/2600Hz/kazoo.git
#cd kazoo
#make
src_test(){
	emake compile-test
}
#make proper
#make build-release
#dosym core/sup/priv/sup /usr/bin/sup
#alias sup='KAZOO_ROOT=/opt/kazoo sup'
