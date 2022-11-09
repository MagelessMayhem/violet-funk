# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux port of Wednesday's Infidelity"

HOMEPAGE="https://github.com/MagelessMayhem/WI-Gentoo"

SRC_URI="https://github.com/MagelessMayhem/WI-Gentoo/archive/refs/tags/v2.0.0-wi.tar.gz"

S="${WORKDIR}/WI-Gentoo-2.0.0-wi"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
          media-sound/pulseaudio
          x11-libs/libX11
          dev-lang/haxe
"

DEPEND="${RDEPEND}"

src_compile() {
    haxelib setup /var/tmp/portage/.local/share/haxe/lib
    cd ${S}
    haxelib run lime build linux -verbose
}
src_install() {
    keepdir "/usr/share/games/Wednesdays-Infidelity"
    insinto "/usr/share/games/Wednesdays-Infidelity"
    doins -r "export/release/linux/bin"
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
}
