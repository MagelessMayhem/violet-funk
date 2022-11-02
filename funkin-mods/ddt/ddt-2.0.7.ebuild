# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Install tentools and systools, both as git.
# You may then rebuild systools for linux.
EAPI=8


DESCRIPTION="The takeover you've been waiting for"

HOMEPAGE="https://github.com/Jorge-SunSpirit/Doki-Doki-Takeover"

# Contains hscript fix + proper Lua modchart setting for Gentoo. Also disables GameJolt integration since it's ultimately unneeded.
SRC_URI="https://github.com/MagelessMayhem/Doki-Doki-Takeover/archive/refs/tags/v2.0.7.tar.gz"

S="${WORKDIR}/Doki-Doki-Takeover-2.0.7"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	=dev-lang/haxe-9999
"
DEPEND="${RDEPEND}"

src_compile() {
	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	cd ../../Doki-Doki-Takeover-2.0.7
	haxelib run lime build linux -verbose
}
src_install() {
	keepdir "/usr/share/games/DDT"
	insinto "/usr/share/games/DDT"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "The mod can be found under /usr/share/games."
}

