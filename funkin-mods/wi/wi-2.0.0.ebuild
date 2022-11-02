# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Wednesday's Infidelity is based on Psych Engine and requires Psych's dependencies.
EAPI=8

DESCRIPTION="The second part to WI"

HOMEPAGE="https://github.com/lunarcleint/Wednesdays-Infidelity"

SRC_URI="https://github.com/MagelessMayhem/wi-gentoo/archive/refs/tags/v2.0.0.tar.gz"

S="${WORKDIR}/wi-gentoo-2.0.0"

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
	keepdir "/usr/share/games/Wednesdays-Infidelity"
	insinto "/usr/share/games/Wednesdays-Infidelity"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod under /usr/share/games."
}
