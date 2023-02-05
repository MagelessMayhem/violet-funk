# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="FNF mod based on a diehard fangirl"

HOMEPAGE="https://github.com/BRN101/Vs_Beepie_master"

SRC_URI="
	https://github.com/MagelessMayhem/Beepie-Gentoo/releases/download/v0.2.7.1-RELFIX/Beepie.tar.gz
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
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/actuate-1,9,0.zip
	https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/linc_luajit-0,0,6.zip
	https://github.com/MagelessMayhem/extension-webm/releases/download/v1.0.0/extension-webm.zip
	https://github.com/MagelessMayhem/hxvm-luajit/releases/download/v1.0.0/hxvm-luajit.zip
"

S="${WORKDIR}/Beepie-Gentoo"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
	+X
	+alsa
	+lime-debug
	lime-final
	lime-release
	pulseaudio
"

REQUIRED_USE="
	X
	alsa
	|| ( lime-debug lime-final lime-release )
	lime-debug? ( !lime-final !lime-release )
	lime-final? ( !lime-debug !lime-release )
	lime-release? ( !lime-debug !lime-final )
"

RDEPEND="
	X? ( x11-base/xorg-server )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"

DEPEND="${RDEPEND}"

BDEPEND="
	app-arch/unzip
	dev-lang/haxe
	media-libs/libvlccore7
	sys-apps/coreutils
	sys-devel/gcc
	sys-devel/binutils
"

src_unpack() {
	unpack Beepie.tar.gz
}
src_compile() {
	# Vs. Beepie requires the building (and therefore linking) of libvlccore.so.7 into the binary, despite not requiring hxCodec. As a result, it uses the system's shared object.
	# If there is any issue that arises because of this, please let me know.

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
	haxelib install ${LIBDIR}/actuate-1,9,0.zip
	haxelib install ${LIBDIR}/linc_luajit-0,0,6.zip
	haxelib install ${LIBDIR}/hxvm-luajit.zip

	# Breaking from the large list of libraries, extension-webm needs to be rebuilt after installation.
	# It is extremely broad and may not function if it is not rebuilt.

	haxelib install ${LIBDIR}/extension-webm.zip
	haxelib run lime rebuild extension-webm linux

	if [ $(usex lime-debug) == "yes" ]; then
		haxelib run lime build linux -debug -v
	elif [ $(usex lime-final) == "yes" ]; then
		haxelib run lime build linux -final -v
	elif [ $(usex lime-release) == "yes" ]; then
		haxelib run lime build linux -v
	fi
}
src_install() {
	keepdir "/usr/share/games/FNF-Beepie"
	insinto "/usr/share/games/FNF-Beepie"
	exeinto "/usr/share/games/FNF-Beepie/bin"
	if [ $(usex lime-debug) == "yes" ]; then
		doins -r "${S}/export/debug/linux/bin"
		doexe "${S}/export/debug/linux/bin/Vs. Beepie"
	else
		doins -r "${S}/export/release/linux/bin"
		doexe "${S}/export/release/linux/bin/Vs. Beepie"
	fi
	echo "( cd /usr/share/games/FNF-Beepie/bin; ./Vs.\ Beepie )" > ${S}/beepie-fnf
	dobin "${S}/beepie-fnf"

	# Vs. Beepie uses its own icon

	newicon -s 16 "${S}/art/icon16.png" "Beepie16.png"
	newicon -s 32 "${S}/art/icon32.png" "Beepie32.png"
	newicon -s 64 "${S}/art/icon64.png" "Beepie64.png"

	make_desktop_entry '/usr/bin/beepie-fnf' 'Vs. Beepie' '/usr/share/icons/hicolor/64x64/apps/Beepie64.png' 'Game'
}
pkg_postinst() {
	xdg_icon_cache_update
}
pkg_postrm() {
	xdg_icon_cache_update
}
