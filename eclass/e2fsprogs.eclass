# Copyright 2018 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

if [ -z "${E2FSPROGS_ECLASS}" ] ; then

case "${EAPI:-0}" in
	6) ;;
	*) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac

inherit rindeal


## git-hosting.eclass:
GH_RN="kernel:fs/ext2:e2fsprogs"
GH_REF="v${PV}"

## EXPORT_FUNCTIONS: src_unpack
inherit git-hosting

## functions: eautoreconf
inherit autotools

## functions: append-cppflags
inherit flag-o-matic

## functions: tc-getCC, tc-getBUILD_CC, tc-getBUILD_LD
inherit toolchain-funcs

## functions: prune_libtool_files
inherit ltprune


HOMEPAGE="http://e2fsprogs.sourceforge.net/ ${GH_HOMEPAGE}"
LICENSE="GPL-2 BSD"

SLOT="0"

IUSE_A=(
	static-libs debug threads
)

inherit arrays


EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install


e2fsprogs_src_unpack() {
	git-hosting_src_unpack
}

e2fsprogs_src_prepare() {
	default

	## don't bother with docs, Gentoo-Bug: 305613
	printf 'all:\n%%:;@:\n' > doc/Makefile.in || die

	eautoreconf
}

e2fsprogs_src_configure() {
	# needs open64() prototypes and friends
	append-cppflags -D_GNU_SOURCE

	export ac_cv_path_LDCONFIG=:
	export CC="$(tc-getCC)"
	export BUILD_CC="$(tc-getBUILD_CC)"
	export BUILD_LD="$(tc-getBUILD_LD)"

	local _econf_args=(
		--enable-option-checking
		--disable-maintainer-mode
		--enable-symlink-install  # use symlinks when installing instead of hard links
		--enable-relative-symlinks  # use relative symlinks when installing
		--enable-symlink-build  # use symlinks while building instead of hard links
		--enable-verbose-makecmds
		$(tc-is-static-only || echo --enable-elf-shlibs)
		--disable-bsd-shlibs
		--disable-profile
		--disable-gcov
		--disable-hardening  # these are just compiler and linker flags
		$(use_enable debug jbd-debug)
		$(use_enable debug blkid-debug)
		$(use_enable debug testio-debug)
		--disable-libuuid  # using newer and better versions from util-linux
		--disable-libblkid  # using newer and better versions from util-linux
		--disable-backtrace
		--disable-debugfs  # enable if needed
		--disable-imager  # enable if needed
		--disable-resizer  # enable if needed
		--disable-defrag  # enable if needed
		--disable-fsck  # using newer and better versions from util-linux
		--disable-e2initrd-helper  # enable if needed
		$(tc-has-tls || echo --disable-tls)
		--disable-uuidd  # using newer and better versions from util-linux
		--disable-mmp  # enable if needed
		--disable-tdb  # enable if needed
		--disable-bmap-stats  # enable if needed
		--disable-bmap-stats-ops  # enable if needed
		--disable-nls  # enable if needed
		$(usex threads "--enable-threads=posix" "--disable-threads")
		--disable-rpath
		--disable-fuse2fs  # enable if needed

		--with-root-prefix="${EPREFIX}/"  # ??

		"${@}"
	)

	econf "${_econf_args[@]}"
}

e2fsprogs_src_compile() {
	local _emake_args=(
		V=1
		"${@}"
	)
	emake "${_emake_args[@]}"
}

e2fsprogs_src_install() {
	local _emake_args=(
		STRIP=:
		DESTDIR="${D}"
		install
		"${@}"
	)

	emake "${_emake_args[@]}"

	prune_libtool_files

	# configure doesn't have an option to disable static libs :/
	if ! use static-libs ; then
		find "${D}" -name '*.a' -delete || die
	fi
}


E2FSPROGS_ECLASS=1
fi
