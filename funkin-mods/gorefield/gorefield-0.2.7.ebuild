# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod is based on Psych Engine and requires Psych dependencies.
# Please refer to Psych's compilation instructions.
EAPI=8

DESCRIPTION="FNF Psych Engine mod based on Gorefield"

HOMEPAGE="https://github.com/JoseXD2/FNF-Vs-Gorefield"

SRC_URI="https://github.com/MagelessMayhem/gorefield/releases/download/v0.2.7-RELEASE/Violet-Gorefield.tar.gz"

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
	keepdir "/usr/share/games/FNF-Gorefield"
	insinto "/usr/share/games/FNF-Gorefield"
	doins -r "Violet-Gorefield/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/FNF-Gorefield"
}
