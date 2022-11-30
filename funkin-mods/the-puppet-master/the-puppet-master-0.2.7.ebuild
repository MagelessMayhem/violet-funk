# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A one-song FNF mod based on TheMaskedChris's characters."

HOMEPAGE="https://github.com/FlorkGames/ESQUECI-AFF"

SRC_URI="https://github.com/MagelessMayhem/TPM-Gentoo/releases/download/v0.2.7-RELEASE/TPM-Gentoo.tar.gz"

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
	keepdir "/usr/share/games/FNF-PuppetMaster"
	insinto "/usr/share/games/FNF-PuppetMaster"
	doins -r "TPM-Gentoo/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run these commands to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/FNF-PuppetMaster"
	elog "chmod 755 /usr/share/games/FNF-PuppetMaster/bin/PsychEngine"
	elog
	elog "Note that the binary installed is treated as an actual mod to"
	elog "the base game. All of the base game's songs are still present,"
	elog "however the mod's song can only be found under freeplay."
}
