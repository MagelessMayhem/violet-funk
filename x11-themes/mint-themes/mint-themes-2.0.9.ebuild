# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="A collection of themes from Linux Mint"
HOMEPAGE="https://github.com/linuxmint/mint-themes"
SRC_URI="
	http://packages.linuxmint.com/pool/main/m/mint-themes/mint-themes_2.0.9_all.deb
	legacy? ( http://packages.linuxmint.com/pool/main/m/mint-themes-legacy/mint-themes-legacy_1.9.2_all.deb )
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
IUSE="legacy"
S="${WORKDIR}"

DEPEND="sys-devel/binutils"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

unpacker_src_unpack() {
	unpacker $(find -name *.deb)
}

src_install() {
	insinto /usr/share
	doins -r ${S}/usr/share/themes
}
