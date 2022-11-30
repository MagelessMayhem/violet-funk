# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod based on Jenny the Teenage Robot"

HOMEPAGE="https://github.com/BRN101/jenny_public_master"

SRC_URI="https://github.com/MagelessMayhem/Violet-Jenny/releases/download/v0.2.7-RELEASE/Violet-Jenny.tar.gz"

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

DEPEND="${RDEPEND}"

src_install() {
	keepdir "/usr/share/games/FNF-Jenny"
	insinto "/usr/share/games/FNF-Jenny"
	doins -r "Violet-Jenny/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run these commands to be able"
	elog "to run it:"
	elog
	elog "sudo chown -R <username> /usr/share/games/FNF-Jenny"
	elog "chmod 755 \"/usr/share/games/FNF-Jenny/bin/Jenny Mod\""
}
