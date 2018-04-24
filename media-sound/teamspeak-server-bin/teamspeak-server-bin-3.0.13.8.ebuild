# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib systemd user

DESCRIPTION="Crystal Clear Cross-Platform Voice Communication Server"
HOMEPAGE="https://www.teamspeak.com/"
SRC_URI="
	amd64? ( http://teamspeak.gameserver.gamed.de/ts3/releases/${PV}/teamspeak3-server_linux_amd64-${PV}.tar.bz2 )
	x86? ( http://teamspeak.gameserver.gamed.de/ts3/releases/${PV}/teamspeak3-server_linux_x86-${PV}.tar.bz2 )"

LICENSE="teamspeak3 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc html systemd tsdns"

RESTRICT="installsources mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/teamspeak3-server"

S="${WORKDIR}/teamspeak3-server_linux_${ARCH}"

pkg_setup() {
	enewuser teamspeak3
}

src_install() {
	# Install wrappers
	dosbin "${FILESDIR}"/ts3server "${FILESDIR}"/ts3server-firejail

	# Install TeamSpeak 3 server into /opt/teamspeak3-server.
	local opt_dir="/opt/teamspeak3-server"
	into ${opt_dir}

	# Install documentation.
	dodoc -r CHANGELOG doc/*.txt

	use doc && dodoc -r serverquerydocs && \
		docompress -x /usr/share/doc/${PF}/serverquerydocs && \
		dosym ../../usr/share/doc/${PF}/serverquerydocs ${opt_dir}/serverquerydocs

	use html && dodoc -r doc/serverquery && \
		docompress -x /usr/share/doc/${PF}/serverquery && \
		dosym ../../../usr/share/doc/${PF}/serverquery ${opt_dir}/doc/serverquery

	# Install local ts3server as ts3server-bin
	newsbin ts3server ts3server-bin

	# 'dolib' may install to libx32 or lib64 - we just want 'lib' alone
	insinto "${opt_dir}"/lib
	doins *.so redist/libmariadb.so.2

	if use tsdns; then
		dosbin tsdns/tsdnsserver
		dodoc tsdns/tsdns_settings.ini.sample
		newdoc tsdns/README README.tsdns
		newdoc tsdns/USAGE USAGE.tsdns
	fi

	insinto "${opt_dir}"/lib
	doins -r sql

	# Install the runtime FS layout.
	insinto /etc/teamspeak3-server
	doins "${FILESDIR}"/server.conf "${FILESDIR}"/ts3db_mariadb.ini

	# Install the init script and systemd unit.
	newinitd "${FILESDIR}"/${PN}-init teamspeak3-server
	newconfd "${FILESDIR}"/${PN}-conf teamspeak3-server
	if use systemd; then
		systemd_newunit "${FILESDIR}"/systemd/teamspeak3-server.service teamspeak3-server.service
		systemd_newtmpfilesd "${FILESDIR}"/systemd/teamspeak3-server.conf teamspeak3-server.conf
	fi

	dodir "${opt_dir}"/license
	keepdir /{etc,var/{lib,log}}/teamspeak3-server

	# Fix up permissions.
	fowners teamspeak3 /{etc,var/{lib,log}}/teamspeak3-server
	fperms 700 /{etc,var/{lib,log}}/teamspeak3-server

	fowners teamspeak3 ${opt_dir}
	fperms 755 ${opt_dir}
}

pkg_postinst() {
	einfo "On the first server start (or after clearing the database) *ONLY*, a new"
	einfo "single-use 'ServerAdmin' key will be logged to"
	einfo
	einfo "    /var/log/teamspeak3-server/ts3server_1.log"
	einfo
	einfo "... the log file for the first TeamSpeak Virtual Server instance."
	einfo
	einfo "You will need to use this key in order to gain instance admin rights."
	einfo
	einfo "Starting with version 3.0.13, there are two important changes:"
	einfo " - IPv6 is now supported."
	einfo " - Binding to any address (0.0.0.0 / 0::0),"
	einfo "   instead of just the default ip of the network interface."
}
