# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

EGIT_BRANCH="master"
EGIT_HAS_SUBMODULES="true"
EGIT_PROJECT="mytetra_dev"
EGIT_REPO_URI="git://github.com/xintrea/mytetra_dev.git"

#inherit qt versionator git

DESCRIPTION="Smart manager for information collecting"
HOMEPAGE="https://github.com/xintrea/mytetra_dev"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

RDEPEND=" dev-qt/qtgui:5
	  dev-qt/qtcore:5
	  dev-qt/qtxmlpatterns:5
	  dev-qt/qtsvg:5"

DEPEND="${RDEPEND}"

src_prepare(){
	sed 's|/usr/local/bin|/usr/bin|' -i mytetra.pro
}

src_install() {
	qt5.7.1_src_install
	domenu desktop/mytetra.desktop
	doicon desktop/mytetra.png
}
