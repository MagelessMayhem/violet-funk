# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Dave Engine is a fork of Kade Engine; it requires Kade dependencies.
# Please refer to Kade's compilation instructions to fetch the proper libraries.
EAPI=8

DESCRIPTION="Linux port of Dave and Bambi"

HOMEPAGE="https://github.com/MagelessMayhem/funkin-dave"

# Built with an hscript fix
SRC_URI="https://github.com/MagelessMayhem/funkin-dave/releases/download/v3.0.0-RELFIX/DNB.tar.gz"

S="${WORKDIR}"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
	+X
	+alsa
	pulseaudio
"

RDEPEND="
	X? ( x11-base/xorg-server )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="${RDEPEND}"
src_install() {
	keepdir "/usr/share/games/DNB-3"
	insinto "/usr/share/games/DNB-3"
	doins -r "DNB-Violet/bin"
}
pkg_postinst() {
	elog "You can find this build in /usr/share/games."
	elog
	elog "You may also need to run this command to execute the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/DNB-3"
	elog "chmod 755 /usr/share/games/DNB-3/bin/VsDave"
	elog
	elog "Huge shoutout to MoldyGH for giving his mod"
	elog "official Linux support. It made this port more"
	elog "convenient to create and maintain."
}
