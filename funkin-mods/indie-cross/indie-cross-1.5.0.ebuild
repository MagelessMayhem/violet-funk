# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod collaboration between notable Indie characters"

HOMEPAGE="https://github.com/brightfyregit/Indie-Cross-Public"

SRC_URI="https://github.com/MagelessMayhem/Violet-IC/releases/download/v1.5.0-RELEASE/Violet-IC.tar.gz"

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
	gnome-base/gconf
	X? ( x11-base/xorg-server )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"

DEPEND="
	${RDEPEND}
"
src_install() {
    keepdir "/usr/share/games/Indie-Cross"
    insinto "/usr/share/games/Indie-Cross"
    doins -r "Violet-IC/bin"
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "Indie Cross requires at least 4 GB of"
    elog "system RAM to run smoothly. You may have"
    elog "performance issues if your system doesn't"
    elog "meet this criteria."
    elog
    elog "You may want to run this command to"
    elog "be able to run the mod:"
    elog
    elog "sudo chown -R <username> /usr/share/games/Indie-Cross"
}
