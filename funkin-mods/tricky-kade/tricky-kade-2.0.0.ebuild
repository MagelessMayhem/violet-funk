# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod requires Kade Engine dependencies.
# Please refer to Kade's compilation instructions to fetch the necessary libraries.
EAPI=8

DESCRIPTION="FNF mod based on Madness Combat's Tricky"

HOMEPAGE="https://github.com/KadeDev/trickster"

# Fork which contains an hscript fix
SRC_URI="https://github.com/MagelessMayhem/tricky-kade/releases/download/v2.0.0-RELFIX/Violet-Tricky.tar.gz"

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
	keepdir "/usr/share/games/tricky-kade"
	insinto "/usr/share/games/tricky-kade"
	doins -r "Violet-Tricky/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/tricky-kade"
	elog "chmod 755 \"/usr/share/games/tricky-kade/bin/Vs Tricky\""
}
