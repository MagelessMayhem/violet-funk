# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod requires Kade Engine dependencies.
# Please refer to Kade's compilation instructions to fetch the proper libraries.
EAPI=8

DESCRIPTION="Scarecrow yells at child for 10 minutes"

HOMEPAGE="https://foo.example.org/"

SRC_URI="ftp://foo.example.org/${P}.tar.gz"

S="${WORKDIR}/zardy-kade-0.2.7.1"

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
	keepdir "/usr/share/games/zardy-kade"
	insinto "/usr/share/games/zardy-kade"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
}