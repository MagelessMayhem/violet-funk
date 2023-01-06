# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Haxe binary package built with FEATURES=\"nostrip\""
HOMEPAGE="https://github.com/HaxeFoundation/haxe https://haxe.org"
SRC_URI="https://github.com/MagelessMayhem/Funkin/releases/download/v0.2.7.1-vf-vanilla/violet-haxe.tar.gz"
S="${WORKDIR}/violet-haxe"
LICENSE="GPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RDEPEND="
	>=dev-lang/ocaml-4:=[ocamlopt?]
	dev-ml/extlib:=
	dev-ml/luv:=
	dev-ml/ocaml-sha:=
	dev-ml/ptmap:=
	dev-ml/sedlex:=
	dev-ml/xml-light:=

	dev-lang/neko:=
	dev-libs/boehm-gc:=
	dev-libs/libpcre:=
	net-libs/mbedtls:=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-ml/camlp5
	dev-ml/dune
	dev-ml/findlib
"
src_install() {
	keepdir "/usr/share/haxe"
	insinto "/usr/share/haxe"
	doins -r ${S}/std/
	doins -r ${S}/lib/
	dobin ${S}/haxe
	dobin ${S}/haxelib
	dodoc -r ${S}/doc/
}
