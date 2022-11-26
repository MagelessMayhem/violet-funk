# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod which encompasses an LGBT character"

HOMEPAGE="https://github.com/mattsodes1031/Softmod-Public"

SRC_URI="https://github.com/MagelessMayhem/FNF-Soft-Gentoo/releases/download/v0.2.7.1-RELFIX/FNF-Soft-Gentoo.tar.gz"

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
    keepdir "/usr/share/games/FNF-Soft"
    insinto "/usr/share/games/FNF-Soft"
    doins -r "Soft-Mod/bin"
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "You may also want to run this command to"
    elog "be able to run the mod:"
    elog
    elog "sudo chown -R <username> /usr/share/games/FNF-Soft"
	elog "chmod 755 \"/usr/share/games/FNF-Soft/bin/Soft Mod\""
}
