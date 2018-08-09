# Copyright 2018 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit rindeal

## git-hosting.eclass:
GH_RN="github:lxqt"
GH_REF="ee9e1e3" # TODO: remove in ver >0.9

## EXPORT_FUNCTIONS: src_unpack
inherit git-hosting
## EXPORT_FUNCTIONS: src_prepare src_configure src_compile src_test src_install
inherit cmake-utils

DESCRIPTION="Terminal emulator widget for Qt5"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64"
IUSE_A=( examples python utf8proc )

CDEPEND_A=(
	">=dev-qt/qtwidgets-5.7.1:5"
	"utf8proc? ( dev-libs/utf8proc:0 )"
)
DEPEND_A=( "${CDEPEND_A[@]}"
	">=dev-qt/linguist-tools-5.7.1:5"
	">=dev-util/lxqt-build-tools-0.5.0:0"
)
RDEPEND_A=( "${CDEPEND_A[@]}" )

REQUIRED_USE_A=(  )
RESTRICT+=""

inherit arrays

L10N_LOCALES=( ca da de el es fr hu ja lt pl pt tr zh_CN zh_TW )
inherit l10n-r1

src_prepare-locales() {
	local l locales dir="lib/translations" pre="qtermwidget_" post=".ts"

	l10n_find_changes_in_dir "${dir}" "${pre}" "${post}"

	l10n_get_locales locales app off
	for l in ${locales} ; do
		rrm "${dir}/${pre}${l}${post}"
	done
}

src_prepare() {
	eapply_user

	src_prepare-locales

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-D UPDATE_TRANSLATIONS=OFF
		-D BUILD_EXAMPLE=$(usex examples)
		-D QTERMWIDGET_USE_UTEMPTER=OFF
		-D QTERMWIDGET_BUILD_PYTHON_BINDING=OFF  # TODO

		-D USE_UTF8PROC=$(usex utf8proc)
	)

	cmake-utils_src_configure
}
