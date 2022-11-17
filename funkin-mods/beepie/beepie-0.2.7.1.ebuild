# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod based on a diehard fangirl"

HOMEPAGE="https://github.com/BRN101/Vs_Beepie_master"

SRC_URI="https://github.com/MagelessMayhem/Beepie-Gentoo/archive/refs/tags/v0.2.7.1-beepie.tar.gz"

S="${WORKDIR}/Beepie-Gentoo-0.2.7.1-beepie"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
	+alsa
	pulseaudio
	pipewire
"

RDEPEND="
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	x11-libs/libX11
	=dev-lang/haxe-9999
"

DEPEND="${RDEPEND}"

src_compile() {
	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	cd ${S}
	haxelib run lime build linux -verbose
}
src_install() {
	keepdir "/usr/share/games/FNF-Beepie"
	insinto "/usr/share/games/FNF-Beepie"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
	elog
	elog "Preferably, you may also run the following"
	elog "command to be able to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/FNF-Beepie"
}
