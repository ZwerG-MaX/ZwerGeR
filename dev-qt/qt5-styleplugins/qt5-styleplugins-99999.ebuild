# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 qmake-utils eutils

DESCRIPTION="Additional style plugins for Qt"
HOMEPAGE="http://code.qt.io/cgit/qt/qtstyleplugins.git/"
LICENSE="LGPL"
SLOT="0"

EGIT_REPO_URI="http://code.qt.io/cgit/qt/qtstyleplugins.git"
EGIT_BRANCH="master"
SRC_URI=""
KEYWORDS="~amd64"

IUSE=""

RDEPEND="dev-qt/qtcore:5
         x11-libs/gtk+:2
         x11-libs/libX11"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	# remove unwanted styles
	for pluginfile in libbb10styleplugin.so libqcleanlooksstyle.so libqmotifstyle.so libqplastiquestyle.so ; do
		rm -rf ${ED}usr/$(get_libdir)/qt5/plugins/styles/"${pluginfile}"
	done
	# remove unwanted cmake files
	for plugincmake in Qt5Widgets_QBB10StylePlugin.cmake Qt5Widgets_QCleanlooksStylePlugin.cmake Qt5Widgets_QMotifStylePlugin.cmake Qt5Widgets_QPlastiqueStylePlugin.cmake ; do
		rm -rf ${ED}usr/$(get_libdir)/cmake/Qt5Widgets/"${plugincmake}"
	done
}
