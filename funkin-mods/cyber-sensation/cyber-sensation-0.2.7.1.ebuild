# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This package requires Kade Engine dependencies.
# Please refer to the Kade Engine compilation instructions to fetch these libraries.
EAPI=8

DESCRIPTION="Explore the cyber world...where someone awaits."
HOMEPAGE="https://github.com/TaeYai/Cyber-Sensation"

# Contains an hscript fix.
SRC_URI="https://github.com/MagelessMayhem/Cyber-Sensation/archive/refs/tags/v0.2.7.1-taeyai.tar.gz"

S="${WORKDIR}/Cyber-Sensation-0.2.7.1-taeyai"

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
	pulseaudio? ( media-sound/pulseaudio[daemon(+)] )
	pipewire? ( media-sound/pulseaudio[daemon(-)] media-video/pipewire[sound-server(+)] )
	x11-libs/libX11
	=dev-lang/haxe-9999
"

DEPEND="
	${RDEPEND}
"
src_compile() {
	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	cd ${S}
	haxelib run lime build linux -verbose
}
src_install() {
	keepdir "/usr/share/games/Cyber-Sensation"
	insinto "/usr/share/games/Cyber-Sensation"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/Cyber-Sensation"
}
