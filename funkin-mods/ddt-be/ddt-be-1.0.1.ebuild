# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Play with me, it's all I have."

HOMEPAGE="https://github.com/Dxgamer7405/Doki-Doki-Takeover-BAD-ENDING"

SRC_URI="https://github.com/MagelessMayhem/ddt-be/releases/download/v1.0.1-RELFIX/ddt-be.tar.gz"

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
	media-libs/libvlccore7
	X? ( x11-base/xorg-server )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"

DEPEND="
	${RDEPEND}
"

src_install() {
	keepdir "/usr/share/games/DDT-Bad-Ending"
	insinto "/usr/share/games/DDT-Bad-Ending"
	doins -r "ddt-be/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run these commands to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/DDT-Bad-Ending"
	elog "chmod 755 \"/usr/share/games/DDT-Bad-Ending/bin/DokiTakeover\""
}
