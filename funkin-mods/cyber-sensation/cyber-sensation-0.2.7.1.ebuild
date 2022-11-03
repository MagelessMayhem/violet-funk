# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This package requires Kade Engine dependencies.
# Please refer to the Kade Engine compilation instructions to fetch these libraries.
EAPI=8

DESCRIPTION="Explore the cyber world...where someone awaits."
HOMEPAGE="https://github.com/TaeYai/Cyber-Sensation"

# Contains an hscript fix.
SRC_URI="https://github.com/MagelessMayhem/Cyber-Sensation/archive/refs/tags/v0.2.7.1.tar.gz"

S="${WORKDIR}/Cyber-Sensation-0.2.7.1"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	media-sound/pulseaudio
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
	keepdir "/usr/games/Cyber-Sensation"
	insinto "/usr/games/Cyber-Sensation"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/games."
}
