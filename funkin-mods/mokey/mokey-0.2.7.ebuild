# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop hxcpp xdg-utils

# Note: Psych Engine mods aren't known for Linux compatibility, but this one seems to work just fine

DESCRIPTION="FNF mod based on SrPelo's Mokey"
HOMEPAGE="https://github.com/MagelessMayhem/VsMokey"
SRC_URI="https://github.com/MagelessMayhem/VsMokey/releases/download/${PV}/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="
	+X
	+alsa
	pulseaudio
	lime-debug
	lime-final
	+lime-release
"
REQUIRED_USE="
	X
	alsa
	|| ( lime-debug lime-final lime-release )
	lime-debug? ( !lime-final !lime-release )
	lime-final? ( !lime-debug !lime-release )
	lime-release? ( !lime-debug !lime-final )
"

# hxcpp.eclass pulls in Haxe for us

DEPEND="
x11-libs/libX11
media-libs/alsa-lib
pulseaudio? ( media-sound/pulseaudio )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	haxelib setup ${S}/.haxelib
	hxcpp_src_prepare

}

src_compile() {

	haxelib setup ${S}/.haxelib

	if use !lime-release; then
		if use lime-debug; then
			HXCPP_LIME_TARGET="debug"
			hxcpp_src_compile
		elif use lime-final; then
			HXCPP_LIME_TARGET="final"
			hxcpp_src_compile
		fi
	else
		hxcpp_src_compile
	fi

}

src_install() {
	
	keepdir "/usr/share/games/VsMokey"
	insinto "/usr/share/games/VsMokey"
	exeinto "/usr/share/games/VsMokey/bin"
	# please don't question the executable name lol
	if use lime-debug; then
		doins -r ${S}/export/debug/linux/bin
		doexe ${S}/export/debug/linux/bin/OHBOI
	else
		doins -r ${S}/export/release/linux/bin
		doexe ${S}/export/release/linux/bin/OHBOI
	fi
	echo '(cd /usr/share/games/VsMokey/bin; ./OHBOI)' > ${WORKDIR}/vsmokey
	dobin ${WORKDIR}/vsmokey
	newicon -s 16 "${S}/art/icon16.png" "VsMokey16.png"
	newicon -s 32 "${S}/art/icon32.png" "VsMokey32.png"
	newicon -s 64 "${S}/art/icon64.png" "VsMokey64.png"
	make_desktop_entry '/usr/bin/vsmokey' "Vs. Mokey" '/usr/share/icons/hicolor/64x64/apps/VsMokey64.png' 'Game'
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
