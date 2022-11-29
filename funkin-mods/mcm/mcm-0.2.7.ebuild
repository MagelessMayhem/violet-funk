# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# MCM requires Psych Engine's dependencies.
# Refer to Psych Engine's compilation instructions.
EAPI=8

DESCRIPTION="FNF mod based on Red Mist and surrounding media"

HOMEPAGE="https://github.com/pahaze/Mistful-Crimson-Morning"

SRC_URI="https://github.com/MagelessMayhem/mcm-gentoo/releases/download/v0.2.7-RELFIX/Violet-Mist.tar.gz"

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
	keepdir "/usr/share/games/MCM-V1"
	insinto "/usr/share/games/MCM-V1"
	doins -r "Violet-Mist/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run these commands to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/MCM-V1"
	elog "chmod 755 /usr/share/games/MCM-V1/bin/Mist"
}
