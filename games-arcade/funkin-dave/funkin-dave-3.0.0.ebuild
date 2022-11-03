# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Dave Engine is a fork of Kade Engine; it requires Kade dependencies.
# Please refer to Kade's compilation instructions to fetch the proper libraries.
EAPI=8

DESCRIPTION="Dave Engine, a fork of Kade Engine"

HOMEPAGE="https://github.com/MoldyGH/VsDave"

# Contains an hscript fix
SRC_URI="https://github.com/MagelessMayhem/funkin-dave/archive/refs/tags/v3.0.0.tar.gz"

S="${WORKDIR}/funkin-dave-3.0.0"

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
	cd ../../funkin-dave-3.0.0
	haxelib run lime build linux -verbose
}
src_install() {
	keepdir "/usr/share/games/Funkin-Dave"
	insinto "/usr/share/games/Funkin-Dave"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find this build in /usr/share/games."
	elog
	elog "Huge shoutout to MoldyGH for giving his engine"
	elog "official Linux support. It made this ebuild more"
	elog "convenient to create and maintain."
}
