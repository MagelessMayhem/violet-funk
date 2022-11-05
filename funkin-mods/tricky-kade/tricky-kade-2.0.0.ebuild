# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod requires Kade Engine dependencies.
# Please refer to Kade's compilation instructions to fetch the necessary libraries.
EAPI=8

DESCRIPTION="FNF mod based on Madness Combat's Tricky"

HOMEPAGE="https://github.com/KadeDev/trickster"

# Fork which contains an hscript fix
SRC_URI="https://github.com/MagelessMayhem/tricky-kade/archive/refs/tags/v2.0.0-tricky.tar.gz"

S="${WORKDIR}/tricky-kade-2.0.0-tricky"

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
	keepdir "/usr/share/games/tricky-kade"
	insinto "/usr/share/games/tricky-kade"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
	elog
        elog "You may also want to run this command to be able"
        elog "to run the mod:"
        elog
        elog "sudo chown -R <username> /usr/share/games/tricky-kade"
}
