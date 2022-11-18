# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Refer to the compilation instructions of FNF to fetch the proper libraries.
# https://github.com/ninjamuffin99/Funkin
EAPI=8

DESCRIPTION="A rhythm game made with HaxeFlixel"
HOMEPAGE="https://ninja-muffin24.itch.io/funkin"
# This tarball contains an hscript fix that allows FNF to compile properly
SRC_URI="
	https://github.com/MagelessMayhem/Funkin/archive/refs/tags/v0.2.7.1-vanilla.tar.gz
	utau? ( https://github.com/MagelessMayhem/vanilla-funkaloid/releases/download/v1.0.0/utau-covers.tar.gz )
	"

S="${WORKDIR}/Funkin-0.2.7.1"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
		+X
		+alsa
		discord-integration
		jack
		pulse-standalone
		pipewire
		tools
		utau
"
DEPEND="
		X? (
			x11-base/xorg-server
			x11-libs/libX11
			x11-base/xorg-drivers
		)
		alsa? ( media-libs/alsa-lib )
		discord-integration? (
			net-im/discord-bin
			x11-misc/xdg-utils
		)
		pulse-standalone? (
			!pipewire? (
				media-sound/pulseaudio[daemon]
			)
		)
		pipewire? (
			pulse-standalone? (
				media-video/pipewire[-sound-server]
				media-sound/pulseaudio[daemon]
			)
			!pulse-standalone? (
				media-video/pipewire[sound-server]
				media-sound/pulseaudio[-daemon]
			)
		)
		tools? (
			jack? ( media-sound/jack2 )
			media-sound/lmms
		)
"

DEPEND="
	${RDEPEND}
"

# Implement a dummy template Haxe file; the game will not compile without it. This is also mentioned in the Funkin compilation instructions.
src_compile() {
	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	if [ -d "${WORKDIR}/assets" ]; then
		cp -r "${WORKDIR}/assets/songs/" "${S}/assets/"
	fi
	cd ${S}
        touch source/APIStuff.hx
        echo "package;
              class APIStuff
              {
                    public static var API:String = \"\";
                    public static var EncKey:String = \"\";
              }
        " | tee -a source/APIStuff.hx
        wait
	haxelib run lime build linux -verbose
	wait

}
src_install() {
	keepdir "/usr/share/games/Funkin"
	insinto "/usr/share/games/Funkin"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "FNF has been installed to /usr/share/games/Funkin."
	elog 
	elog "You may need to run this command to run it:"
	elog
	elog "sudo chown -R <username> /usr/share/games/Funkin"
	elog
	elog "If you want UTAU covers, enable the utau USE flag and"
	elog "remerge this package."
}
