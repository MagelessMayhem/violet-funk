# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod is based on Kade Engine.
# Please refer to Kade's compilation instructions to fetch the proper dependencies.
EAPI=8

DESCRIPTION="Kade Engine mod based on Flippy, a character from Happy Tree Friends"
HOMEPAGE="https://github.com/Yirius125/FNF-VsFliqpy-1.5-Full-Week-Engine"
SRC_URI="https://github.com/MagelessMayhem/fliqpy-kade/releases/download/v0.2.7.1-RELFIX/fliqpy-kade.tar.gz"

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
	keepdir "/usr/share/games/fliqpy-kade"
	insinto "/usr/share/games/fliqpy-kade"
	doins -r "fliqpy-kade/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
	elog
	elog "You may also want to run these commands to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/fliqpy-kade"
	elog "chmod 755 \"/usr/share/games/fliqpy-kade/bin/Kade Engine\""
}
