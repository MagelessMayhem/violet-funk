# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Install tentools and systools, both as git.
# You may then rebuild systools for linux.
EAPI=8


DESCRIPTION="The takeover you've been waiting for"

HOMEPAGE="https://github.com/Jorge-SunSpirit/Doki-Doki-Takeover"

# Contains hscript fix + proper Lua modchart setting for Gentoo. Also disables GameJolt integration since it's ultimately unneeded.
SRC_URI="https://github.com/MagelessMayhem/Doki-Doki-Takeover/releases/download/v2.0.7-RELFIX/DDT.tar.gz"

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
	keepdir "/usr/share/games/DDT"
	insinto "/usr/share/games/DDT"
	doins -r "DDT-Violet/bin"
}
pkg_postinst() {
	elog "The mod can be found under /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/DDT"
	elog "chmod 755 /usr/share/games/DDT/bin/DokiTakeover"
}

