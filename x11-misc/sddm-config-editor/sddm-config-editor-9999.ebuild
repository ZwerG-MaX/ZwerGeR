# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
#QT5_MODULE="qttools"
inherit qmake-utils

DESCRIPTION="SDDM Configuration Editor"
HOMEPAGE="https://github.com/hagabaka/sddm-config-editor"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hagabaka/${PN}.git"
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	dev-qt/qtquickcontrols:5
	>=x11-misc/sddm-0.15.0
	sys-auth/polkit
"
RDEPEND="${DEPEND}"