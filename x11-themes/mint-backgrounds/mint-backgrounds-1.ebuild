# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Generally cleaner (and easier) to use the .deb packages, since they already provide the hierarchy for installing the files
# As a result of this, the unpacker eclass is needed to properly extract them

inherit unpacker

DESCRIPTION="USE-based meta package for Linux Mint backgrounds"
HOMEPAGE=""
SRC_URI="
	xfce? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-xfce/mint-backgrounds-xfce_2017.10.27_all.deb )
	vera? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-vera/mint-backgrounds-vera_1.0_all.deb )
	vanessa? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-vanessa/mint-backgrounds-vanessa_1.1_all.deb )
	una? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-una/mint-backgrounds-una_1.1_all.deb )
	uma? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-uma/mint-backgrounds-uma_1.2_all.deb )
	ulyssa? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-ulyssa/mint-backgrounds-ulyssa_1.1_all.deb )
	ulyana? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-ulyana/mint-backgrounds-ulyana_1.1_all.deb )
	tricia? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-tricia/mint-backgrounds-tricia_1.1_all.deb )
	tina? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-tina/mint-backgrounds-tina_1.2_all.deb )
	tessa? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-tessa/mint-backgrounds-tessa_1.1_all.deb )
	tara? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-tara/mint-backgrounds-tara_1.1_all.deb )
	sylvia? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-sylvia/mint-backgrounds-sylvia_1.2_all.deb )
	sonya? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-sonya/mint-backgrounds-sonya_1.1_all.deb )
	serena? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-serena/mint-backgrounds-serena_1.1_all.deb )
	sarah? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-sarah/mint-backgrounds-sarah_1.1_all.deb )
	rosa? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-rosa/mint-backgrounds-rosa_1.2_all.deb )
	retro? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-retro/mint-backgrounds-retro_1.3_all.deb )
	rebecca? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-rebecca/mint-backgrounds-rebecca_1.5_all.deb )
	rafaela? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-rafaela/mint-backgrounds-rafaela_1.2_all.deb )
	qiana? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-qiana/mint-backgrounds-qiana_1.5_all.deb )
	petra? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-petra/mint-backgrounds-petra_1.7_all.deb )
	olivia? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-olivia/mint-backgrounds-olivia_1.7_all.deb )
	nadia-extra? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-nadia-extra/mint-backgrounds-nadia-extra_1.0_all.deb )
	nadia? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-nadia/mint-backgrounds-nadia_1.4_all.deb )
	maya-extra? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-maya-extra/mint-backgrounds-maya-extra_1.1_all.deb )
	maya? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-maya/mint-backgrounds-maya_1.5_all.deb )
	lisa-extra? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-lisa-extra/mint-backgrounds-lisa-extra_1.1_all.deb )
	lisa? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-lisa/mint-backgrounds-lisa_1.1_all.deb )
	katya-extra? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-katya-extra/mint-backgrounds-katya-extra_1.0.1_all.deb )
	katya? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-katya/mint-backgrounds-katya_1.0.1_all.deb )
	julia? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-julia/mint-backgrounds-julia_1.0_all.deb )
	isadora? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-isadora/mint-backgrounds-isadora_1.0_all.deb )
	helena? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-helena/mint-backgrounds-helena_1.0_all.deb )
	debian? ( http://packages.linuxmint.com/pool/main/m/mint-backgrounds-debian/mint-backgrounds-debian_1.4_all.deb )
"

LICENSE="CC0-1.0 CC-BY-NC-ND-4.0 CC-BY-SA-4.0 GPL-3 metapackage"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
S="${WORKDIR}"
IUSE="
	xfce
	+vera
	vanessa
	una
	uma
	ulyssa
	ulyana
	tricia
	tina
	tessa
	tara
	sylvia
	sonya
	serena
	sarah
	rosa
	retro
	rebecca
	rafaela
	qiana
	petra
	olivia
	nadia
	nadia-extra
	maya
	maya-extra
	lisa
	lisa-extra
	katya
	katya-extra
	julia
	isadora
	helena
	debian
"
REQUIRED_USE="|| (
	xfce
	vera
	vanessa
	una
	uma
	ulyssa
	ulyana
	tricia
	tina
	tessa
	tara
	sylvia
	sonya
	serena
	sarah
	rosa
	retro
	rebecca
	rafaela
	qiana
	petra
	olivia
	nadia
	nadia-extra
	maya
	maya-extra
	lisa
	lisa-extra
	katya
	katya-extra
	julia
	isadora
	helena
	debian
)
"
DEPEND="sys-devel/binutils"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

unpacker_src_unpack() {
	unpacker $(find -name *.deb)
}

src_install() {
	insinto /usr/share
	doins -r ${S}/usr/share/backgrounds
}
