# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs desktop

DESCRIPTION="FNF mod based on and written by Tae Yai"
HOMEPAGE="https://github.com/TaeYai/Cyber-Sensation"

# Since Cyber Sensation is a Kade Engine mod, we need additional dependencies.
# These are extension-webm, actuate, hxvm-luajit, and linc_luajit.
# Except for extension-webm and hxvm-luajit, these can be installed directly through haxelib.

SRC_URI="
	https://github.com/MagelessMayhem/Cyber-Sensation/releases/download/v0.2.7.1-CS/Cyber-Sensation.tar.gz
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

S="${WORKDIR}/Cyber-Sensation"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="
	+X
	+alsa
	pulseaudio
"
REQUIRED_USE="
	X
	alsa
"
DEPEND="
	X? ( x11-libs/libX11 )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"

RDEPEND="${DEPEND}"

BDEPEND="
	app-arch/unzip
	dev-lang/haxe
	sys-apps/coreutils
	sys-devel/binutils
	sys-devel/gcc
"

CHECKREQS_DISK_BUILD="2G"
CHECKREQS_DISK_USR="400M"
CHECKREQS_DISK_VAR="3G"

pkg_setup() {
	check-reqs_pkg_setup
}

src_unpack() {
	unpack Cyber-Sensation.tar.gz
}

src_compile() {

	LIBDIR="/var/cache/distfiles"
	addread ${LIBDIR}

	haxelib newrepo

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

	haxelib run lime build linux
}

src_install() {
	keepdir "/usr/share/games/Cyber-Sensation"
	insinto "/usr/share/games/Cyber-Sensation"
	doins -r "${S}/export/release/linux/bin"
	exeinto "/usr/share/games/Cyber-Sensation/bin"
	doexe "${S}/export/release/linux/bin/Kade Engine"
	echo "( cd /usr/share/games/Cyber-Sensation/bin; ./Kade\ Engine )" > ${S}/cyber-sensation
	dobin "${S}/cyber-sensation"

	# Note: Not installing new icons since Cyber Sensation uses the same icon as FNF
	# You can request the installation of icons if desired, however
	# Also, if FNF (games-arcade/funkin) is installed, Cyber Sensation will simply use the icon it installed

	make_desktop_entry '/usr/bin/cyber-sensation' 'Cyber Sensation' '/usr/share/icons/hicolor/32x32/apps/Funkin32.png' 'Game'
}
pkg_postinst() {
	elog "The mod may not run on first execution, and that is because it doesn't have access to its own folder."
	elog
	elog "You can take ownership of the folder to circumvent this issue:"
	elog
	elog "sudo chown -R <username> /usr/share/games/Cyber-Sensation/bin"
}
