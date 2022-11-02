# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Indie Cross requires systools and tentools.
EAPI=8

DESCRIPTION="FNF mod collaboration between iconic Indie characters"

HOMEPAGE="https://github.com/brightfyregit/Indie-Cross-Public"

SRC_URI="https://github.com/MagelessMayhem/indie-cross/archive/refs/tags/v1.5.0.tar.gz"

S="${WORKDIR}/indie-cross-1.5.0"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
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
	keepdir "/usr/share/games/Indie-Cross"
	insinto "/usr/share/games/Indie-Cross"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
}
