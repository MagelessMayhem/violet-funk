# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux port of Wednesday's Infidelity"

HOMEPAGE="https://github.com/MagelessMayhem/WI-Gentoo"

SRC_URI="private-build? ( https://github.com/MagelessMayhem/WI-Gentoo/releases/download/v2.0.0-RELFIX/WI-Gentoo-BD.tar.gz )
	!private-build? ( https://github.com/MagelessMayhem/WI-Gentoo/releases/download/v2.0.0-RELFIX/WI-Gentoo.tar.gz )"

S="${WORKDIR}"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
	+X
	+alsa
	pulseaudio
	private-build
"

RDEPEND="
	X? ( x11-base/xorg-server )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"

DEPEND="
	${RDEPEND}
"
src_install() {
	keepdir "/usr/share/games/Wednesdays-Infidelity"
	insinto "/usr/share/games/Wednesdays-Infidelity"
	if [[ -d "WI-Gentoo-BD/" ]]; then
		doins -r "WI-Gentoo-BD/bin"
	else
		doins -r "WI-Gentoo/bin"
	fi
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "Wednesday's Infidelity requires at least 4 GB"
    elog "of system RAM to run smoothly. You may have"
    elog "performance issues if your system doesn't meet"
    elog "this criteria."
    elog
    elog "Also, to be able to run the mod, you can use"
    elog "the following command:"
    elog
    elog "sudo chown -R <username> /usr/share/games/Wednesdays-Infidelity"
    elog "chmod 755 \"/usr/share/games/Wednesdays-Infidelity/bin/Wednesday's Infidelity\""
    elog
    elog "Note that the game currently doesn't run with shaders, meaning"
    elog "you will need to disable them to play it."
    elog
    elog "If you enabled the private-build USE flag, you will be able to"
    elog "unlock multiple features, including a universal pause and botplay"
    elog "toggle. For more information, please view the README.md file at"
    elog "https://github.com/lunarcleint/Wednesdays-Infidelity."
}
