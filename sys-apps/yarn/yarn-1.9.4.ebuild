# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fast, reliable, and secure node dependency management"
HOMEPAGE="https://yarnpkg.com"
SRC_URI="https://github.com/yarnpkg/yarn/releases/download/v${PV}/yarn-v${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="!dev-util/cmdtest
	net-libs/nodejs[npm]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_install() {
	local install_dir path
	install_dir="/usr/$(get_libdir)/node_modules/yarn"
	insinto "${install_dir}"
	doins -r .
	dosym "../$(get_libdir)/node_modules/yarn/bin/yarn.js" "/usr/bin/yarn"
	fperms a+x "${install_dir}/bin/yarn.js"
	while read -r -d '' path; do
		[[ $(head -n1 "${path}") == \#\!* ]] || continue
		chmod +x "${path}" || die #614094
	done < <(find "${ED}" -type f -print0)
}
