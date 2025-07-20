# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Haxe - The Cross-Platform Toolkit"
HOMEPAGE="https://haxe.org"
SRC_URI="https://github.com/HaxeFoundation/haxe/releases/download/4.3.7/haxe-4.3.7-linux64.tar.gz"
S="${WORKDIR}/haxe_20250509143529_e0b355c"
LICENSE="GPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"

# Same dependencies as the vanilla Haxe ebuild, minus BDEPEND

DEPEND="
dev-lang/neko
dev-lang/ocaml
dev-libs/boehm-gc
dev-libs/libpcre
dev-ml/extlib
dev-ml/luv
dev-ml/ocaml-sha
dev-ml/ptmap
dev-ml/sedlex
dev-ml/xml-light
net-libs/mbedtls
sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dodir "/usr/lib/haxe/"
	insinto "/usr/lib/haxe/"
	doins -r ${S}/std

	into "/usr/bin"
	dobin ${S}/haxe
	dobin ${S}/haxelib

	into "/etc/env.d"
	echo "HAXE_STD_PATH=/usr/lib/haxe/std" > ${S}/00haxe
	doins ${S}/00haxe
}

pkg_postinst() {
	elog "The HAXE_STD_PATH environment variable has been manually set. You will need to update your shell to apply this change."
}
