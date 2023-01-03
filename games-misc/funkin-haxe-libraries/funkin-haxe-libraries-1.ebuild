# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An ebuild which installs Haxe dependencies for building FNF and FNF mods"

SRC_URI="
	base-libs? (
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
		https://github.com/MagelessMayhem/discord-rpc/releases/download/1.0.0/linc_discord-rpc.zip
	)

	kade-libs? (
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/actuate-1,9,0.zip
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/linc_luajit-0,0,6.zip
		https://github.com/MagelessMayhem/extension-webm/releases/download/v1.0.0/extension-webm.zip
		https://github.com/MagelessMayhem/hxvm-luajit/releases/download/v1.0.0/hxvm-luajit.zip
	)

	psych-libs? (
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/tjson-1,4,0.zip
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/hxjsonast-1,1,0.zip
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/hxCodec-2,5,1.zip
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/hxcpp-debug-server-1,2,4.zip
		https://github.com/MagelessMayhem/hscript-ex/releases/download/v1.0.0/hscript-ex.zip
	)

	specialty-libs? (
		https://haxelib-tr40bgq5.fra1.cdn.digitaloceanspaces.com/files/3.0/flxanimate-1,2,0.zip
	)
"
LICENSE="MIT specialty-libs? ( LGPL-2.1 )"

# S doesn't matter, does it?

S=${WORKDIR}/..

SLOT=0

KEYWORDS="~amd64"

IUSE="
	+base-libs
	kade-libs
	psych-libs
	specialty-libs
"
BDEPEND="
	app-arch/unzip
	dev-lang/haxe
	sys-devel/gcc
"
DEPEND="${BDEPEND}"

src_compile() {

	if [ $(usex base-libs) == "no" ]; then

		die "The base-libs USE flag must be enabled! Aborting installation." 

	fi

	LIBDIR="/var/cache/distfiles"
	addread ${LIBDIR}

	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	addpredict /var/tmp/portage/.local/share/haxe/lib

	if [ $(usex base-libs) == "yes" ]; then

		haxelib install ${LIBDIR}/flixel-4,11,0.zip
		haxelib install ${LIBDIR}/newgrounds-1,1,5.zip
		haxelib install ${LIBDIR}/hxcpp-4,2,1.zip
		haxelib install ${LIBDIR}/flixel-ui-2,5,0.zip
		haxelib install ${LIBDIR}/flixel-addons-3,0,0.zip
		haxelib install ${LIBDIR}/openfl-9,1,0.zip
		haxelib install ${LIBDIR}/lime-8,0,0.zip
		haxelib install ${LIBDIR}/hscript-2,5,0.zip
		haxelib install ${LIBDIR}/polymod-1,6,0.zip
		haxelib install ${LIBDIR}/linc_discord-rpc.zip
		haxelib install ${LIBDIR}/lime-samples-7,0,0.zip
		haxelib install ${LIBDIR}/lime-tools-1,5,7.zip
		haxelib install ${LIBDIR}/flixel-tools-1,5,1.zip
		haxelib install ${LIBDIR}/flixel-templates-2,6,6.zip
		haxelib install ${LIBDIR}/flixel-demos-2,9,0.zip

	fi

	if [ $(usex kade-libs) == "yes" ]; then

		haxelib install ${LIBDIR}/actuate-1,9,0.zip
		haxelib install ${LIBDIR}/linc_luajit-0,0,6.zip
		haxelib install ${LIBDIR}/hxvm-luajit.zip
		haxelib install ${LIBDIR}/faxe.zip
		haxelib install ${LIBDIR}/extension-webm.zip
		haxelib run lime rebuild extension-webm linux

	fi

	if [ $(usex psych-libs) == "yes" ]; then

		haxelib install ${LIBDIR}/tjson-1,4,0.zip
		haxelib install ${LIBDIR}/hxjsonast-1,1,0.zip
		haxelib install ${LIBDIR}/hxCodec-2,5,1.zip
		haxelib install ${LIBDIR}/hxcpp-debug-server-1,2,4.zip
		haxelib install ${LIBDIR}/hscript-ex.zip

	fi

	if [ $(usex specialty-libs) == "yes" ]; then

		haxelib install ${LIBDIR}/flxanimate-1,2,0.zip

	fi
}
