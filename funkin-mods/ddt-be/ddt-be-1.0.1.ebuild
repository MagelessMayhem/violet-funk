# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod requires Kade Engine dependencies.
# Please refer to Kade's compilation instructions to fetch the proper libraries.
EAPI=8

DESCRIPTION="Play with me, it's all I have."

HOMEPAGE="https://github.com/Dxgamer7405/Doki-Doki-Takeover-BAD-ENDING"

SRC_URI="https://github.com/MagelessMayhem/ddt-be/archive/refs/tags/v1.0.1-ddt-be.tar.gz"

S="${WORKDIR}/ddt-be-1.0.1-ddt-be"

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
BDEPEND="
	=dev-lang/haxe-9999
	sys-devel/gcc
"

src_compile() {
	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	cd ${S}
	haxelib run lime build linux -verbose
}
src_install() {
	keepdir "/usr/share/games/DDT-Bad-Ending"
	insinto "/usr/share/games/DDT-Bad-Ending"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
	elog
	elog "You may also want to run this command to be able"
	elog "to run the mod:"
	elog
	elog "sudo chown -R <username> /usr/share/games/DDT-Bad-Ending"
}
