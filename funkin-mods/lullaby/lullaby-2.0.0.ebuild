# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Please use the following commands to properly compile Lullaby:
# sudo haxelib install flxanimate
# sudo haxelib git hxCodec https://github.com/polybiusproxy/hxCodec
# sudo haxelib run lime rebuild hxCodec linux
# sudo ltf-conf
EAPI=8

DESCRIPTION="Forever Engine port of Hypno's Lullaby"
HOMEPAGE="https://github.com/MAJigsaw77/Lullaby-Forever"

# Contains an hscript fix.
SRC_URI="https://github.com/MagelessMayhem/Lullaby-Forever/archive/refs/tags/v2.0.0.tar.gz"

S="${WORKDIR}/Lullaby-Forever-2.0.0"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	media-sound/pulseaudio
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
	keepdir "/usr/share/games/FNF-Lullaby"
	insinto "/usr/share/games/FNF-Lullaby"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "The mod can be found under /usr/share/games."
}
