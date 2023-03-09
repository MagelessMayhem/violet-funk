# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="The icon themes for Linux Mint"
HOMEPAGE="https://github.com/linuxmint/mint-x-icons https://github.com/linuxmint/mint-y-icons"
SRC_URI="http://packages.linuxmint.com/pool/main/m/mint-y-icons/mint-y-icons_1.6.4_all.deb
	legacy? ( http://packages.linuxmint.com/pool/main/m/mint-y-icons-legacy/mint-y-icons-legacy_1.6.3_all.deb )
	mint-x? ( http://packages.linuxmint.com/pool/main/m/mint-x-icons/mint-x-icons_1.6.4_all.deb )"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="legacy mint-x"
S="${WORKDIR}"

DEPEND="sys-devel/binutils"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

unpacker_src_unpack() {
	unpacker $(find -name *.deb)
}

src_install() {
	insinto /usr/share
	doins -r ${S}/usr/share/icons
}
pkg_postinst() {
	xdg_icon_cache_update
}
pkg_postrm() {
	xdg_icon_cache_update
}
