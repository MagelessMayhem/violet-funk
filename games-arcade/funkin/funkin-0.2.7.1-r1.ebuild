# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs desktop hxcpp xdg-utils

DESCRIPTION="A rhythm game made with HaxeFlixel"
HOMEPAGE="https://github.com/FunkinCrew/Funkin"

# The only archive we need to extract out of these (as defined in src_unpack()) is the FNF source code.
# If the utau USE flag is enabled, however, we should also extract the song covers.

SRC_URI="
	https://github.com/MagelessMayhem/Funkin/releases/download/v0.2.7.1-vf-vanilla/Funkin-VF.tar.gz
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flixel-4,11,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/newgrounds-1,1,5.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/hxcpp-4,2,1.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flixel-ui-2,5,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/openfl-9,1,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/lime-8,0,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/hscript-2,5,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/polymod-1,6,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/lime-tools-1,5,7.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/lime-samples-7,0,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flixel-addons-3,0,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flixel-tools-1,5,1.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flixel-demos-2,9,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flixel-templates-2,6,6.zip
	https://github.com/MagelessMayhem/discord-rpc/releases/download/1.0.0/discord_rpc.zip
	utau? ( https://github.com/MagelessMayhem/vanilla-funkaloid/releases/download/v1.0.0/utau-covers.tar.gz )
	"

S="${WORKDIR}/Funkin"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RESTRICT="strip"
# FNF requires X AT MINIMUM to compile properly (since it uses libX11.so).
# alsa is enabled because FNF is a rhythm game and you'd be insane to play a rhythm game without sound.

IUSE="
	+X
	+alsa
	+lime-debug
	lime-final
	lime-release
	pulseaudio
	utau
"
REQUIRED_USE="
	X
	alsa
	|| ( lime-debug lime-final lime-release )
	lime-debug? ( !lime-final !lime-release )
	lime-final? ( !lime-debug !lime-release )
	lime-release? ( !lime-debug !lime-final )
"
# Any desktop profile should already have libX11 and alsa-lib installed.

RDEPEND="
	X? ( x11-libs/libX11 )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="
	${RDEPEND}
"
# Haxe 4.3 is on track to introduce bit-wise data types, which the game's source code does not support
# Therefore, unless the game is updated to support Haxe 4.3 (judging from the new features), its Haxe dependency will be version-locked
BDEPEND="
	app-arch/unzip
	<dev-lang/haxe-4.3
	sys-apps/coreutils
	sys-devel/gcc
	sys-devel/binutils
"

CHECKREQS_DISK_BUILD="2000M"
CHECKREQS_DISK_VAR="2700M"
CHECKREQS_DISK_USR="350M"


pkg_setup() {
	check-reqs_pkg_setup
}

src_unpack() {
	unpack Funkin-VF.tar.gz
	if use utau; then
		unpack utau-covers.tar.gz
	fi
}

src_prepare() {

	eapply_user

	haxelib newrepo

	LIBDIR="/var/cache/distfiles"
	addread ${LIBDIR}

	haxelib install ${LIBDIR}/flixel-4,11,0.zip
	haxelib install ${LIBDIR}/newgrounds-1,1,5.zip
	haxelib install ${LIBDIR}/hxcpp-4,2,1.zip
	haxelib install ${LIBDIR}/flixel-ui-2,5,0.zip
	haxelib install ${LIBDIR}/flixel-addons-3,0,0.zip
	haxelib install ${LIBDIR}/openfl-9,1,0.zip
	haxelib install ${LIBDIR}/lime-8,0,0.zip
	haxelib install ${LIBDIR}/hscript-2,5,0.zip
	haxelib install ${LIBDIR}/polymod-1,6,0.zip
	haxelib install ${LIBDIR}/discord_rpc.zip
	haxelib install ${LIBDIR}/lime-samples-7,0,0.zip
	haxelib install ${LIBDIR}/lime-tools-1,5,7.zip
	haxelib install ${LIBDIR}/flixel-tools-1,5,1.zip
	haxelib install ${LIBDIR}/flixel-templates-2,6,6.zip
	haxelib install ${LIBDIR}/flixel-demos-2,9,0.zip

	hxcpp_src_prepare
}

src_compile() {

	if use utau; then
		cp -r "${WORKDIR}/assets/songs/" "${S}/assets/"
	fi

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
	keepdir "/usr/share/games/Funkin"
	insinto "/usr/share/games/Funkin"
	exeinto "/usr/share/games/Funkin/bin"
	if use lime-debug; then
		doins -r "${S}/export/debug/linux/bin"
		doexe "${S}/export/debug/linux/bin/Funkin"
	else
		doins -r "${S}/export/release/linux/bin"
		doexe "${S}/export/release/linux/bin/Funkin"
	fi
	echo '(cd /usr/share/games/Funkin/bin; ./Funkin)' > "${WORKDIR}/funkin"
	dobin "${WORKDIR}/funkin"
	newicon -s 32 "${S}/art/icon32.png" "Funkin32.png"
	newicon -s 16 "${S}/art/icon16.png" "Funkin16.png"
	newicon -s 64 "${S}/art/icon64.png" "Funkin64.png"
	make_desktop_entry '/usr/bin/funkin' "Friday Night Funkin'" '/usr/share/icons/hicolor/64x64/apps/Funkin64.png' 'Game'
}
pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	elog "The following are known (potential) issues with the software:"
	elog
	elog "- One less song shows up in story mode per week."
	elog "- The options menu lacks critical functionality shown in modding engines (such as the ability to set controls)."
	elog
	elog "These issues should be submitted to https://github.com/FunkinCrew/Funkin to be fixed."
	elog
	elog "Any issues with the ebuild and not the software installed by the ebuild may appropriately be submitted to the Gentoo Bugzilla."
}
pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	elog "Any save data stored on the disk has not been removed.\n\nThis save data should be in ~/.local/, and you may wipe it if you wish."
}
