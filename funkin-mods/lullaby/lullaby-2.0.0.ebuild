# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Forever Engine port of Hypno's Lullaby"
HOMEPAGE="https://github.com/MAJigsaw77/Lullaby-Forever"

SRC_URI="https://github.com/MagelessMayhem/Lullaby-Forever/releases/download/v2.0.0-RELFIX/Violet-Lullaby-LD.tar.gz"

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
	keepdir "/usr/share/games/FNF-Lullaby-LD"
	insinto "/usr/share/games/FNF-Lullaby-LD"
	doins -r "Violet-Lullaby-LD/bin"
}
pkg_postinst() {
	elog "The mod can be found under /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/FNF-Lullaby-LD"
	elog
	elog "This build of Hypno's Lullaby has been modified to be"
	elog "compatible with the lowest difficulty. It is still playable"
	elog "on the other difficulties."
}
