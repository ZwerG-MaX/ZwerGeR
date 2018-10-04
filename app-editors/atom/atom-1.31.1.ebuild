# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# NOTE: this ebuild has been generated by atom-ebuild-gen.py from the
#       atom overlay.  If you would like to make changes, please consider
#       modifying the ebuild template and submitting a PR to
#       https://github.com/elprans/atom-overlay.

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit multiprocessing python-single-r1 rpm xdg-utils

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io"
MY_PV="${PV//_/-}"

ELECTRON_V=2.0.7
ELECTRON_SLOT=2.0

ASAR_V=0.14.3
# All binary packages depend on this
NAN_V=2.11.1

ATOM__NSFW_V=1.0.20
ATOM__WATCHER_V=1.0.8
CACHED_RUN_IN_THIS_CONTEXT_V=0.4.1
CTAGS_V=3.0.0
FS_ADMIN_V=0.1.7
GIT_UTILS_V=5.2.1
KEYBOARD_LAYOUT_V=2.0.13
KEYTAR_V=4.2.1
NSLOG_V=3.0.0
ONIGURUMA_V=6.2.1
PATHWATCHER_V=8.0.1
SCROLLBAR_STYLE_V=3.2.0
SPELLCHECKER_V=3.5.0
SUPERSTRING_V=2.3.4
TREE_SITTER_V=0.13.8
TREE_SITTER_BASH_V=0.13.3
TREE_SITTER_C_V=0.13.5
TREE_SITTER_CPP_V=0.13.5
TREE_SITTER_EMBEDDED_TEMPLATE_V=0.13.0
TREE_SITTER_GO_V=0.13.1
TREE_SITTER_HTML_V=0.13.4
TREE_SITTER_JAVASCRIPT_V=0.13.7
TREE_SITTER_PYTHON_V=0.13.4
TREE_SITTER_REGEX_V=0.13.1
TREE_SITTER_RUBY_V=0.13.10
TREE_SITTER_TYPESCRIPT_V=0.13.4

# The x86_64 arch below is irrelevant, as we will rebuild all binary packages.
SRC_URI="
	https://github.com/${PN}/${PN}/releases/download/v${MY_PV}/atom.x86_64.rpm -> atom-bin-${MY_PV}.rpm
	https://github.com/${PN}/${PN}/archive/v${MY_PV}.tar.gz -> atom-${MY_PV}.tar.gz
	https://github.com/elprans/asar/releases/download/v${ASAR_V}-gentoo/asar-build.tar.gz -> asar-${ASAR_V}.tar.gz
	https://github.com/nodejs/nan/archive/v${NAN_V}.tar.gz -> nodejs-nan-${NAN_V}.tar.gz
	https://registry.npmjs.org/@atom/nsfw/-/nsfw-1.0.20.tgz -> atomdep-atom--nsfw-${ATOM__NSFW_V}.tar.gz
	https://registry.npmjs.org/@atom/watcher/-/watcher-1.0.8.tgz -> atomdep-atom--watcher-${ATOM__WATCHER_V}.tar.gz
	http://registry.npmjs.org/cached-run-in-this-context/-/cached-run-in-this-context-0.4.1.tgz -> atomdep-cached-run-in-this-context-${CACHED_RUN_IN_THIS_CONTEXT_V}.tar.gz
	https://registry.npmjs.org/ctags/-/ctags-3.0.0.tgz -> atomdep-ctags-${CTAGS_V}.tar.gz
	https://registry.npmjs.org/fs-admin/-/fs-admin-0.1.7.tgz -> atomdep-fs-admin-${FS_ADMIN_V}.tar.gz
	https://registry.npmjs.org/git-utils/-/git-utils-5.2.1.tgz -> atomdep-git-utils-${GIT_UTILS_V}.tar.gz
	https://registry.npmjs.org/keyboard-layout/-/keyboard-layout-2.0.13.tgz -> atomdep-keyboard-layout-${KEYBOARD_LAYOUT_V}.tar.gz
	https://registry.npmjs.org/keytar/-/keytar-4.2.1.tgz -> atomdep-keytar-${KEYTAR_V}.tar.gz
	https://registry.npmjs.org/nslog/-/nslog-3.0.0.tgz -> atomdep-nslog-${NSLOG_V}.tar.gz
	https://registry.npmjs.org/oniguruma/-/oniguruma-6.2.1.tgz -> atomdep-oniguruma-${ONIGURUMA_V}.tar.gz
	https://registry.npmjs.org/pathwatcher/-/pathwatcher-8.0.1.tgz -> atomdep-pathwatcher-${PATHWATCHER_V}.tar.gz
	https://registry.npmjs.org/scrollbar-style/-/scrollbar-style-3.2.0.tgz -> atomdep-scrollbar-style-${SCROLLBAR_STYLE_V}.tar.gz
	https://registry.npmjs.org/spellchecker/-/spellchecker-3.5.0.tgz -> atomdep-spellchecker-${SPELLCHECKER_V}.tar.gz
	https://registry.npmjs.org/superstring/-/superstring-2.3.4.tgz -> atomdep-superstring-${SUPERSTRING_V}.tar.gz
	https://registry.npmjs.org/tree-sitter/-/tree-sitter-0.13.8.tgz -> atomdep-tree-sitter-${TREE_SITTER_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-bash/-/tree-sitter-bash-0.13.3.tgz -> atomdep-tree-sitter-bash-${TREE_SITTER_BASH_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-c/-/tree-sitter-c-0.13.5.tgz -> atomdep-tree-sitter-c-${TREE_SITTER_C_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-cpp/-/tree-sitter-cpp-0.13.5.tgz -> atomdep-tree-sitter-cpp-${TREE_SITTER_CPP_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-embedded-template/-/tree-sitter-embedded-template-0.13.0.tgz -> atomdep-tree-sitter-embedded-template-${TREE_SITTER_EMBEDDED_TEMPLATE_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-go/-/tree-sitter-go-0.13.1.tgz -> atomdep-tree-sitter-go-${TREE_SITTER_GO_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-html/-/tree-sitter-html-0.13.4.tgz -> atomdep-tree-sitter-html-${TREE_SITTER_HTML_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-javascript/-/tree-sitter-javascript-0.13.7.tgz -> atomdep-tree-sitter-javascript-${TREE_SITTER_JAVASCRIPT_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-python/-/tree-sitter-python-0.13.4.tgz -> atomdep-tree-sitter-python-${TREE_SITTER_PYTHON_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-regex/-/tree-sitter-regex-0.13.1.tgz -> atomdep-tree-sitter-regex-${TREE_SITTER_REGEX_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-ruby/-/tree-sitter-ruby-0.13.10.tgz -> atomdep-tree-sitter-ruby-${TREE_SITTER_RUBY_V}.tar.gz
	https://registry.npmjs.org/tree-sitter-typescript/-/tree-sitter-typescript-0.13.4.tgz -> atomdep-tree-sitter-typescript-${TREE_SITTER_TYPESCRIPT_V}.tar.gz
"

BINMODS=(
	atom--nsfw
	atom--watcher
	cached-run-in-this-context
	ctags
	fs-admin
	git-utils
	keyboard-layout
	keytar
	nslog
	oniguruma
	pathwatcher
	scrollbar-style
	spellchecker
	superstring
	tree-sitter
	tree-sitter-bash
	tree-sitter-c
	tree-sitter-cpp
	tree-sitter-embedded-template
	tree-sitter-go
	tree-sitter-html
	tree-sitter-javascript
	tree-sitter-python
	tree-sitter-regex
	tree-sitter-ruby
	tree-sitter-typescript
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-util/electron-${ELECTRON_V}:${ELECTRON_SLOT}
"

DEPEND="
	>=app-text/hunspell-1.3.3:=
	>=dev-libs/libgit2-0.23:=[ssh]
	>=dev-libs/libpcre2-10.22:=[jit,pcre16]
	>=dev-libs/oniguruma-6.6.0:=
	>=dev-util/ctags-5.8
	>=gnome-base/libgnome-keyring-3.12:=
	x11-libs/libxkbfile
"

RDEPEND="
	${DEPEND}
	>=dev-util/electron-${ELECTRON_V}:${ELECTRON_SLOT}
	dev-vcs/git
	!sys-apps/apmd
"

S="${WORKDIR}/${PN}-${MY_PV}"
BIN_S="${WORKDIR}/${PN}-bin-${MY_PV}"
BUILD_DIR="${S}/out"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_unpack() {
	local a

	mkdir "${BIN_S}" || die

	for a in ${A} ; do
		case "${a}" in
			*.rpm)
				pushd "${BIN_S}" >/dev/null || die
				srcrpm_unpack "${a}"
				popd >/dev/null || die
				;;

			*.tar|*.tar.gz|*.tar.bz2|*.tar.xz)
				# Tarballs on registry.npmjs.org are wildly inconsistent,
				# and violate the convention of having ${P} as the top
				# directory name, so we strip the first component and
				# unpack into a correct directory explicitly.
				local basename=${a%.tar.*}
				local destdir=${WORKDIR}/${basename#atomdep-}
				mkdir "${destdir}" || die
				tar -C "${destdir}" -x -o --strip-components 1 \
					-f "${DISTDIR}/${a}" || die
				;;

			*)
				# Fallback to the default unpacker.
				unpack "${a}"
				;;
		esac
	done
}

src_prepare() {
	local suffix="$(get_install_suffix)"
	local atom_rpmdir=$(get_atom_rpmdir)
	local install_dir="${EPREFIX}$(get_install_dir)"
	local electron_dir="${EPREFIX}$(get_electron_dir)"
	local electron_path="${electron_dir}/electron"
	local node_path="${electron_dir}/node"
	local node_includes="${EPREFIX}$(get_node_includedir)"
	local binmod
	local pkgdir

	mkdir "${BUILD_DIR}" || die
	cp -a "${BIN_S}/${atom_rpmdir}/resources/app" \
		"${BUILD_DIR}/app" || die

	# Add source files omitted from the upstream binary distribution,
	# and which we want to include in ours.
	cp -a "${S}/spec" "${BUILD_DIR}/app" || die

	# Unpack app.asar
	easar extract "${BIN_S}/${atom_rpmdir}/resources/app.asar" \
		"${BUILD_DIR}/app"

	cd "${BUILD_DIR}/app" || die

	eapply "${FILESDIR}/apm-python.patch"
	eapply "${FILESDIR}/atom-unbundle-electron-r3.patch"
	eapply "${FILESDIR}/atom-python-r1.patch"
	eapply "${FILESDIR}/atom-apm-path-r2.patch"
	eapply "${FILESDIR}/atom-fix-app-restart-r2.patch"
	eapply "${FILESDIR}/atom-marker-layer-r1.patch"
	eapply "${FILESDIR}/atom-fix-config-watcher-r1.patch"

	sed -i -e "s|path.join(process.resourcesPath, 'LICENSE.md')|'/usr/share/licenses/$(get_atom_appname)/LICENSE.md'|g" \
		./src/main-process/atom-application.js \
		|| die

	sed -i -e "s|{{NPM_CONFIG_NODEDIR}}|${node_includes}|g" \
			-e "s|{{ATOM_PATH}}|${electron_path}|g" \
			-e "s|{{ATOM_RESOURCE_PATH}}|${install_dir}/app.asar|g" \
			-e "s|{{ATOM_PREFIX}}|${EPREFIX}|g" \
			-e "s|^#!/bin/bash|#!${EPREFIX}/bin/bash|g" \
		./atom.sh \
		|| die

	local env="export NPM_CONFIG_NODEDIR=${node_includes}\nexport ELECTRON_NO_ASAR=1"
	sed -i -e \
		"s|\"\$binDir/\$nodeBin\"|${env}\nexec \"${node_path}\"|g" \
			apm/bin/apm || die

	sed -i -e \
		"s|^\([[:space:]]*\)node[[:space:]]\+|\1\"${node_path}\" |g" \
			apm/node_modules/npm/bin/node-gyp-bin/node-gyp || die

	sed -i -e \
		"s|atomCommand = 'atom';|atomCommand = '${EPREFIX}/usr/bin/atom${suffix}'|g" \
			apm/lib/test.js || die

	rm apm/bin/node || die

	sed -i -e "s|/${atom_rpmdir}/atom|${EPREFIX}/usr/bin/atom${suffix}|g" \
		"${BIN_S}/usr/share/applications/$(get_atom_appname).desktop" || die

	for binmod in "${BINMODS[@]}"; do
		pkgdir="${WORKDIR}/$(package_dir ${binmod})"
		cd "${pkgdir}" || die
		if have_patches_for "${binmod}"; then
			eapply "${FILESDIR}"/${binmod}-*.patch
		fi
	done

	cd "${BUILD_DIR}/app" || die

	# Unbundle bundled libs from modules

	pkgdir="${WORKDIR}/$(package_dir git-utils)"
	${EPYTHON} "${FILESDIR}/gyp-unbundle.py" \
		--inplace --unbundle "git;libgit2;git2" \
		"${pkgdir}/binding.gyp" || die

	pkgdir="${WORKDIR}/$(package_dir oniguruma)"
	${EPYTHON} "${FILESDIR}/gyp-unbundle.py" \
		--inplace --unbundle "onig_scanner;oniguruma;onig" \
		"${pkgdir}/binding.gyp" || die

	pkgdir="${WORKDIR}/$(package_dir spellchecker)"
	${EPYTHON} "${FILESDIR}/gyp-unbundle.py" \
		--inplace --unbundle "spellchecker;hunspell;hunspell" \
		"${pkgdir}/binding.gyp" || die

	pkgdir="${WORKDIR}/$(package_dir superstring)"
	${EPYTHON} "${FILESDIR}/gyp-unbundle.py" \
		--inplace --unbundle \
		"superstring_core;./vendor/pcre/pcre.gyp:pcre;pcre2-16; \
			-DPCRE2_CODE_UNIT_WIDTH=16" \
		"${pkgdir}/binding.gyp" || die

	for binmod in "${BINMODS[@]}"; do
		pkgdir="${WORKDIR}/$(package_dir ${binmod})"
		mkdir -p "${pkgdir}/node_modules" || die
		ln -s "${WORKDIR}/nodejs-nan-${NAN_V}" \
			"${pkgdir}/node_modules/nan" || die
	done

	sed -i -e "s|{{ATOM_PREFIX}}|${EPREFIX}|g" \
		"${BUILD_DIR}/app/src/config-schema.js" || die

	sed -i -e "s|{{ATOM_SUFFIX}}|${suffix}|g" \
		"${BUILD_DIR}/app/src/config-schema.js" || die

	eapply_user
}

src_configure() {
	local binmod

	for binmod in "${BINMODS[@]}"; do
		einfo "Configuring ${binmod}..."
		cd "${WORKDIR}/$(package_dir ${binmod})" || die
		enodegyp_atom configure
	done
}

src_compile() {
	local binmod
	local ctags_d="node_modules/symbols-view/vendor"
	local jobs=$(makeopts_jobs)
	local unpacked_paths

	# Transpile any yet untranspiled files.
	ecoffeescript "${BUILD_DIR}"/app/spec/'*.coffee'

	mkdir -p "${BUILD_DIR}/modules/" || die

	for binmod in "${BINMODS[@]}"; do
		local binmod_name=${binmod##node-}

		einfo "Building ${binmod}..."
		cd "${WORKDIR}/$(package_dir ${binmod})" || die
		enodegyp_atom --verbose --jobs="$(makeopts_jobs)" build
		mkdir -p "${BUILD_DIR}/modules/${binmod_name}" || die
		cp build/Release/*.node "${BUILD_DIR}/modules/${binmod_name}" || die
	done

	# Put compiled binary modules in place
	fix_binmods "${BUILD_DIR}/app" "apm"
	fix_binmods "${BUILD_DIR}/app" "node_modules"

	# Remove non-Linux vendored ctags binaries
	rm "${BUILD_DIR}/app/${ctags_d}/ctags-darwin" \
		"${BUILD_DIR}/app/${ctags_d}/ctags-win32.exe" || die

	# Remove bundled git
	rm -r "${BUILD_DIR}/app/node_modules/dugite/git" || die

	# Re-pack app.asar
	# Keep unpack rules in sync with buildAsarUnpackGlobExpression()
	# in script/lib/package-application.js
	unpacked_paths=(
		"*.node"
		"ctags-config"
		"ctags-linux"
		"**/spec/fixtures/**"
		"**/node_modules/github/bin/**"
		"**/node_modules/spellchecker/**"
		"**/resources/atom.png")

	unpacked_paths=$(IFS=,; echo "${unpacked_paths[*]}")

	cd "${BUILD_DIR}" || die
	easar pack --unpack="{${unpacked_paths}}" --unpack-dir=apm "app" "app.asar"

	rm -r "${BUILD_DIR}/app.asar.unpacked/apm" || die

	# Replace vendored ctags with a symlink to system ctags
	rm "${BUILD_DIR}/app.asar.unpacked/${ctags_d}/ctags-linux" || die
	ln -s "${EPREFIX}/usr/bin/ctags" \
		"${BUILD_DIR}/app.asar.unpacked/${ctags_d}/ctags-linux" || die
}

src_install() {
	local install_dir="$(get_install_dir)"
	local suffix="$(get_install_suffix)"

	insinto "${install_dir}"

	doins "${BUILD_DIR}/app.asar"
	doins -r "${BUILD_DIR}/app.asar.unpacked"

	insinto "${install_dir}/app"
	doins -r "${BUILD_DIR}/app/apm"

	insinto "/usr/share/applications/"
	newins "${BIN_S}/usr/share/applications/$(get_atom_appname).desktop" \
		"atom${suffix}.desktop"

	insinto "/usr/share/icons/"
	doins -r "${BIN_S}/usr/share/icons/hicolor"

	exeinto "${install_dir}"
	newexe "${BUILD_DIR}/app/atom.sh" atom
	insinto "/usr/share/licenses/${PN}${suffix}"
	doins "${BIN_S}/$(get_atom_rpmdir)/resources/LICENSE.md"
	dosym "../..${install_dir}/atom" "/usr/bin/atom${suffix}"
	dosym "../..${install_dir}/app/apm/bin/apm" "/usr/bin/apm${suffix}"

	fix_executables "${install_dir}/app/apm/bin"
	fix_executables "${install_dir}/app/apm/node_modules/.bin"
	fix_executables "${install_dir}/app/apm/node_modules/npm/bin"
	fix_executables "${install_dir}/app/apm/node_modules/npm/bin/node-gyp-bin"
	fix_executables "${install_dir}/app/apm/node_modules/node-gyp/bin"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

# Helpers
# -------

# Return the installation suffix appropriate for the slot.
get_install_suffix() {
	local slot=${SLOT%%/*}
	local suffix

	if [[ "${slot}" == "0" ]]; then
		suffix=""
	else
		suffix="-${slot}"
	fi

	echo "${suffix}"
}

# Return the upstream app name appropriate for $PV.
get_atom_appname() {
	if [[ "${PV}" == *beta* ]]; then
		echo "atom-beta"
	else
		echo "atom"
	fi
}

# Return the app installation path inside the upstream archive.
get_atom_rpmdir() {
	echo "usr/share/$(get_atom_appname)"
}

# Return the installation target directory.
get_install_dir() {
	echo "/usr/$(get_libdir)/atom$(get_install_suffix)"
}

# Return the Electron installation directory.
get_electron_dir() {
	echo "/usr/$(get_libdir)/electron-${ELECTRON_SLOT}"
}

# Return the directory containing appropriate Node headers
# for the required version of Electron.
get_node_includedir() {
	echo "/usr/include/electron-${ELECTRON_SLOT}/node/"
}

# Run JavaScript using Electron's version of Node.
enode_electron() {
	"${BROOT}/$(get_electron_dir)"/node "${@}"
}

# Run node-gyp using Electron's version of Node.
enodegyp_atom() {
	local apmpath="$(get_atom_rpmdir)/resources/app/apm"
	local nodegyp="${BIN_S}/${apmpath}/node_modules/node-gyp/bin/node-gyp.js"

	PATH="${BROOT}/$(get_electron_dir):${PATH}" \
		enode_electron "${nodegyp}" \
			--nodedir="${BROOT}/$(get_node_includedir)" "${@}" || die
}

# Coffee Script wrapper.
ecoffeescript() {
	local cscript="${FILESDIR}/transpile-coffee-script.js"

	echo "ecoffeescript" "${@}"
	echo ATOM_HOME="${T}/.atom" ATOM_SRC_ROOT="${BUILD_DIR}/app" \
	NODE_PATH="${BUILD_DIR}/app/node_modules" \
		enode_electron "${cscript}" "${@}" || die
	ATOM_HOME="${T}/.atom" ATOM_SRC_ROOT="${BUILD_DIR}/app" \
	NODE_PATH="${BUILD_DIR}/app/node_modules" \
		enode_electron "${cscript}" "${@}" || die
}

# asar wrapper.
easar() {
	local asar="${WORKDIR}/$(package_dir asar)/node_modules/asar/bin/asar"
	echo "asar" "${@}"
	enode_electron "${asar}" "${@}" || die
}

# Return a $WORKDIR directory for a given package name.
package_dir() {
	local binmod="${1//-/_}"
	local binmod_v="${binmod^^}_V"
	if [[ -z "${binmod_v}" ]]; then
		die "${binmod_v} is not set."
	fi

	echo ${1}-${!binmod_v}
}

# Check if there are patches for a given package.
have_patches_for() {
	local patches="${1}-*.patch"
	local found
	found=$(find "${FILESDIR}" -maxdepth 1 -name "${patches}" -print -quit)
	test -n "${found}"
}

# Replace binary node modules with the newly compiled versions thereof.
fix_binmods() {
	local dir="${2}"
	local prefix="${1}"
	local path
	local relpath
	local modpath
	local mod
	local cruft

	while IFS= read -r -d '' path; do
		relpath=${path#${prefix}}
		relpath=${relpath##/}
		relpath=${relpath#W${dir}}
		modpath=$(dirname ${relpath})
		modpath=${modpath%build/Release}
		mod=$(basename ${modpath})

		# Check if the binary node module is actually a valid dependency.
		# Sometimes the upstream removes a dependency from package.json but
		# forgets to remove the module from node_modules.
		has "${mod}" "${BINMODS[@]}" || continue

		# Must copy here as symlinks will cause the module loading to fail.
		cp -f "${BUILD_DIR}/modules/${mod}/${path##*/}" "${path}" || die

		# Drop unnecessary static libraries.
		find "${path%/*}" -name '*.a' -delete || die
	done < <(find "${prefix}/${dir}" -name '*.node' -print0 || die)
}

# Fix script permissions and shebangs to point to the correct version
# of Node.
fix_executables() {
	local dir="${1}"
	local node_sb="#!${EPREFIX}$(get_electron_dir)"/node

	while IFS= read -r -d '' f; do
		IFS= read -r shebang < "${f}"

		if [[ ${shebang} == '#!'* ]]; then
			fperms +x "${f#${ED}}"
			if [[ "${shebang}" == "#!/usr/bin/env node" || \
					"${shebang}" == "#!/usr/bin/node" ]]; then
				einfo "Fixing node shebang in ${f#${ED}}"
				sed --follow-symlinks -i \
					-e "1s:${shebang}$:${node_sb}:" "${f}" || die
			fi
		fi
	done < <(find -L "${ED}${dir}" -maxdepth 1 -mindepth 1 -type f -print0 || die)
}