# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod is based on Kade Engine.
# Please refer to Kade's compilation instructions to fetch the proper dependencies.
EAPI=8

DESCRIPTION="Oh, he's flippin' out"
HOMEPAGE="https://github.com/Yirius125/FNF-VsFliqpy-1.5-Full-Week-Engine"
SRC_URI="https://github.com/MagelessMayhem/fliqpy-kade/archive/refs/tags/v0.2.7.1.tar.gz"

S="${WORKDIR}/fliqpy-kade-0.2.7.1"

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
	keepdir "/usr/games/fliqpy-kade"
	insinto "/usr/games/fliqpy-kade"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
}
