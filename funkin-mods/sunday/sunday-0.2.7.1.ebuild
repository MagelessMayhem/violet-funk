# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod by bbpanzu based on a wannabe rockstar"

HOMEPAGE="https://github.com/bbpanzu/FNF-Sunday"

SRC_URI="https://github.com/MagelessMayhem/Violet-Sunday/releases/download/v0.2.7.1-RELFIX/Violet-Sunday.tar.gz"

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
    keepdir "/usr/share/games/FNF-Sunday"
    insinto "/usr/share/games/FNF-Sunday"
    doins -r "Violet-Sunday/bin"
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "You may also want to run this command to"
    elog "be able to run the mod:"
    elog
    elog "sudo chown -R <username> /usr/share/games/FNF-Sunday"
	elog "chmod 755 \"/usr/share/games/FNF-Sunday/bin/Vs Sunday\""
}
