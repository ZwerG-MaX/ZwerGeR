# Copyright 2018 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit rindeal

## git-hosting.eclass:
GH_RN="github:lxqt"
GH_REF="f28b4e9" # TODO: remove in ver >0.9.0

## EXPORT_FUNCTIONS: src_unpack
inherit git-hosting

## EXPORT_FUNCTIONS: src_prepare src_configure src_compile src_test src_install
inherit cmake-utils

## EXPORT_FUNCTIONS: src_prepare pkg_preinst pkg_postinst pkg_postrm
inherit xdg

DESCRIPTION="Lightweight Qt terminal emulator based on QTermWidget"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64"
IUSE_A=( )

CDEPEND_A=(
	"dev-qt/qtx11extras:5"
	"x11-libs/qtermwidget:0"

	"dev-qt/qtgui:5"
	"dev-qt/qtwidgets:5"

	"dev-qt/qtdbus:5" # this is automagic dep

	"x11-libs/libX11:0"
)
DEPEND_A=( "${CDEPEND_A[@]}"
	"dev-util/lxqt-build-tools:0"
	"dev-qt/linguist-tools:5"
)
RDEPEND_A=( "${CDEPEND_A[@]}" )

REQUIRED_USE_A=(  )
RESTRICT+=""

inherit arrays

L10N_LOCALES=( ar ca cs da de el es et fr hu it ja lt nl pl pt pt_BR ru tr uk zh_CN zh_TW )
inherit l10n-r1

src_prepare-locales() {
	local l locales dir="src/translations" pre="qterminal_" post=".ts"

	l10n_find_changes_in_dir "${dir}" "${pre}" "${post}"

	l10n_get_locales locales app off
	for l in ${locales} ; do
		rrm "${dir}/${pre}${l}${post}"
	done
}

src_prepare() {
	eapply_user

	src_prepare-locales

	xdg_src_prepare

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
	)

	cmake-utils_src_configure
}