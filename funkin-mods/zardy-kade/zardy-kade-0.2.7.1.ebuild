# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod requires Kade Engine dependencies.
# Please refer to Kade's compilation instructions to fetch the proper libraries.
EAPI=8

DESCRIPTION="FNF mod based around a scarecrow and his cablestand"

HOMEPAGE="https://github.com/KadeDev/Vs-Zardy"

SRC_URI="https://github.com/MagelessMayhem/zardy-kade/archive/refs/tags/v0.2.7.1.tar.gz"

S="${WORKDIR}/zardy-kade-0.2.7.1"

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
	keepdir "/usr/share/games/zardy-kade"
	insinto "/usr/share/games/zardy-kade"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
}
