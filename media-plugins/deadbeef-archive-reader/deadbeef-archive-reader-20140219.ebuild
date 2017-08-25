# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit deadbeef-plugins subversion

DESCRIPTION="DeaDBeeF vfs archive reader plugin with gzip, 7z and rar support"
HOMEPAGE="https://www.assembla.com/spaces/deadbeef_vfs_archive_reader"
ESVN_REPO_URI="https://subversion.assembla.com/svn/deadbeef_vfs_archive_reader/trunk/src"
ESVN_REVISION="16"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	epatch "${FILESDIR}/${PN}-flags.patch"
}
