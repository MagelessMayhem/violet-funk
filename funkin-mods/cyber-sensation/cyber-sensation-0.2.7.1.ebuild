# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This package requires Kade Engine dependencies.
# Please refer to the Kade Engine compilation instructions to fetch these libraries.
EAPI=8

DESCRIPTION="Explore the cyber world...where someone awaits."
HOMEPAGE="https://github.com/TaeYai/Cyber-Sensation"

# Built with an hscript fix.
SRC_URI="https://github.com/MagelessMayhem/Cyber-Sensation/releases/download/v0.2.7.1-RELEASE/Cyber-Sensation.tar.gz"

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

DEPEND="
	${RDEPEND}
"
src_install() {
	keepdir "/usr/share/games/Cyber-Sensation"
	insinto "/usr/share/games/Cyber-Sensation"
	doins -r "Cyber-Sensation/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/Cyber-Sensation"
}
