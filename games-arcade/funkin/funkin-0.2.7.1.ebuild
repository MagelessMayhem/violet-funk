# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="An open-source rhythm game written using HaxeFlixel"
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

LICENSE="Apache-2.0 MIT"

SLOT="0"

KEYWORDS="~amd64"

# FNF requires X AT MINIMUM to compile properly (since it uses libX11.so).
# alsa is enabled because FNF is a rhythm game and you'd be insane to play a rhythm game without sound.

IUSE="
		+X
		+alsa
		pulseaudio
		utau
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
BDEPEND="
		app-arch/unzip
		dev-lang/haxe
		sys-apps/coreutils
		sys-devel/gcc
		sys-devel/binutils
"
src_unpack() {
	unpack Funkin-VF.tar.gz
	if [ $(usex utau) == "yes" ]; then
		unpack utau-covers.tar.gz
	fi
}
src_compile() {

	# Although the majority of users should have libX11 installed, the USE flag shouldn't be disabled.

	if [ $(usex X) == "no" ]; then

		die "Error: The X USE flag is disabled. Please enable it to compile FNF."

	fi

	# Note: Source tarball already has APIStuff.hx included
	# We don't need to create the file here

	if [ -d "${WORKDIR}/assets" ]; then
		cp -r "${WORKDIR}/assets/songs/" "${S}/assets/"
	fi

	# FNF requires several Haxe libraries for it to compile correctly.
	# This was previously handled by a package named funkin-haxe-libraries, which has since been removed.
	# They are being installed here for the sake of Portage and my own sanity.

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

	# Building the debug target to make it easier to pinpoint issues with the game itself	
	haxelib run lime build linux -debug
}
src_install() {
	keepdir "/usr/share/games/Funkin"
	insinto "/usr/share/games/Funkin"
	doins -r "${S}/export/debug/linux/bin"
	exeinto "/usr/share/games/Funkin/bin"
	doexe "${S}/export/debug/linux/bin/Funkin"
	echo '(cd /usr/share/games/Funkin/bin; ./Funkin)' > "${WORKDIR}/funkin"
	dobin "${WORKDIR}/funkin"
	newicon -s 32 "${S}/art/icon32.png" "Funkin32.png"
	newicon -s 16 "${S}/art/icon16.png" "Funkin16.png"
	newicon -s 64 "${S}/art/icon64.png" "Funkin64.png"
	make_desktop_entry '/usr/bin/funkin' "Friday Night Funkin'" '/usr/share/icons/hicolor/32x32/apps/Funkin32.png' 'Game'
}
pkg_postinst() {
	xdg_icon_cache_update
	elog "The following are known (potential) issues with the software:"
	elog
	elog "- One less song shows up in story mode per week."
	elog "- The options menu lacks critical functionality shown in modding engines (such as the ability to set controls)."
	elog
	elog "These issues should be submitted to https://github.com/FunkinCrew/Funkin to be fixed."
	elog
	elog "Any issues with the ebuild and not the software installed by the ebuild may appropriately be submitted to the Gentoo Bugzilla."
}
