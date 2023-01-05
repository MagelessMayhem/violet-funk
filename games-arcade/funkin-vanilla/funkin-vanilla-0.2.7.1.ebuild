# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="A rhythm game made with HaxeFlixel, originally made for Ludum Dare 47's \"Stuck in a Loop\""
HOMEPAGE="https://github.com/FunkinCrew/Funkin"

SRC_URI="
	https://github.com/MagelessMayhem/Funkin/releases/download/v0.2.7.1-vf-vanilla/haxe-bin.zip
	https://github.com/MagelessMayhem/Funkin/releases/download/v0.2.7.1-vf-vanilla/Funkin-VF.tar.gz
	utau? ( https://github.com/MagelessMayhem/vanilla-funkaloid/releases/download/v1.0.0/utau-covers.tar.gz )
	"

S="${WORKDIR}/Funkin"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
		+X
		+alsa
		pulseaudio
		utau
"
# x11-base/xorg-server pulls in x11-libs/libX11, which is what FNF needs to run.
# This will also pull in x11-base/xorg-drivers, allowing you to run the game seamlessly.
RDEPEND="
		X? ( x11-base/xorg-server )
		alsa? ( media-libs/alsa-lib )
		pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
		app-arch/unzip
		dev-lang/haxe
		games-misc/funkin-haxe-libraries[base-libs]
		sys-devel/gcc
		sys-devel/binutils
		sys-apps/coreutils
"
src_unpack() {
	unpack haxe-bin.zip
	unpack Funkin-VF.tar.gz
	if [ $(usex utau) == "yes" ]; then
		unpack utau-covers.tar.gz
	fi
}
src_compile() {

	HAXE_STD_PATH=${WORKDIR}/haxe-bin/std
	HAXELIB_PATH=${WORKDIR}/haxe-bin
	HAXE_PATH=${WORKDIR}/haxe-bin

	# Note: Source tarball already has APIStuff.hx included
	# We don't need to create the file here

	if [ -d "${WORKDIR}/assets" ]; then
		cp -r "${WORKDIR}/assets/songs/" "${S}/assets/"
	fi

	alias haxe='${WORKDIR}/haxe-bin/haxe'
	alias haxelib='${WORKDIR}/haxe-bin/haxelib'

	addread /usr/share/haxe

	mkdir -p /var/tmp/portage/.local/share/haxe
	cp -r /usr/share/haxe/lib /var/tmp/portage/.local/share/haxe/

	haxelib setup /var/tmp/portage/.local/share/haxe/lib

	haxelib run lime build linux -debug -v
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
	elog "FNF has been installed to /usr/share/games/Funkin."
	elog
	elog "You may need to take ownership of the game folder to run it properly:"
	elog
	elog "sudo chown -R <username> /usr/share/games/Funkin"
	elog
	elog "If you want UTAU covers, enable the utau USE flag and"
	elog "remerge this package."
}
