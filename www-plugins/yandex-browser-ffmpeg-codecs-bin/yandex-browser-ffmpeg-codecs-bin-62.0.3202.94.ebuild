# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

KEYWORDS="~x86 ~amd64"
DESCRIPTION="Multi-threaded ffmpeg codecs needed for the HTML5 <audio> and <video> tags"
HOMEPAGE="http://www.chromium.org/Home"
SLOT="0"
LICENSE="BSD"
RESTRICT="bindist strip mirror"

DEBIAN_REVISION="0ubuntu0.17.04.1388"
_FULL_VERSION="${PV}-${DEBIAN_REVISION}"
BASE_URI="http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser"
SRC_URI="
	x86? ( ${BASE_URI}/chromium-codecs-ffmpeg-extra_${_FULL_VERSION}_i386.deb )
	amd64? ( ${BASE_URI}/chromium-codecs-ffmpeg-extra_${_FULL_VERSION}_amd64.deb )
"
S="${WORKDIR}"
YANDEX_HOME="opt/yandex/browser-beta"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	keepdir "${YANDEX_HOME}"
	insinto "${YANDEX_HOME}"
	doins usr/lib/chromium-browser/libffmpeg.so
}
