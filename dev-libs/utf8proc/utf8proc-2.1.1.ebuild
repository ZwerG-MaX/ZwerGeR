# Copyright 1999-2016 Gentoo Foundation
# Copyright 2017-2018 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit rindeal

## git-hosting.eclass:
GH_RN="github:JuliaLang"
GH_REF="v${PV}"

## EXPORT_FUNCTIONS: src_unpack
## variables: GH_HOMEPAGE
inherit git-hosting

## EXPORT_FUNCTIONS: src_prepare src_configure src_compile src_test src_install
inherit cmake-utils

DESCRIPTION="mapping tool for UTF-8 strings"
HOMEPAGE="http://julialang.org/utf8proc/ ${GH_HOMEPAGE}"
LICENSE="MIT unicode"

# subslot follows ABI version number, which is defined in `Makefile` or `CMakeLists.txt`
SLOT="0/${PV}"

KEYWORDS="amd64"
IUSE_A=( )

inherit arrays

src_prepare() {
	eapply_user

	rsed -e '/include.*utils.cmake/a include(GNUInstallDirs)'  -i -- CMakeLists.txt
	rsed -r -e '/set.*C_FLAGS/ s, -(O[0-9]|pedantic),,g' -i -- CMakeLists.txt
	rsed -e '/add_library/ s,$, SHARED,' -i -- CMakeLists.txt
	rsed -e '/SOVERSION/ s,$, PUBLIC_HEADER utf8proc.h,' -i -- CMakeLists.txt
	echo 'install(TARGETS utf8proc LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})' >> CMakeLists.txt || die
	echo 'MESSAGE(STATUS ${CMAKE_INSTALL_INCLUDEDIR})'  >> CMakeLists.txt || die

	cmake-utils_src_prepare

}

src_configure() {
	local mycmakeargs=(
# 		-D WITH_FOO=$(usex foo)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
# 	local emake_args=(
# 		DESTDIR="${ED}"
# 		prefix="${EPREFIX}"/usr
# 		includedir="${EPREFIX}"/usr/include
# 		libdir="${EPREFIX}/usr/$(get_libdir)"
# 	)
# 	emake "${emake_args[@]}" install

	dodoc NEWS.md
}
