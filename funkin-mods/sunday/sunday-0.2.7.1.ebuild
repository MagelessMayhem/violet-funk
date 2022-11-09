# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod by bbpanzu based on a wannabe rockstar"

HOMEPAGE="https://github.com/bbpanzu/FNF-Sunday"

SRC_URI="https://github.com/MagelessMayhem/Violet-Sunday/archive/refs/tags/v0.2.7.1-sunday.tar.gz"

S="${WORKDIR}/Violet-Sunday-0.2.7.1-sunday"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
        dev-lang/luajit
        media-sound/pulseaudio
        x11-libs/libX11
        dev-lang/haxe-9999
"

DEPEND="${RDEPEND}"

src_compile() {
    haxelib setup /var/tmp/portage/.local/share/haxe/lib/
    cd ${S}
    haxelib run lime build linux -verbose
}
src_install() {
    keepdir "/usr/share/games/FNF-Sunday"
    insinto "/usr/share/games/FNF-Sunday"
    doins -r "export/release/linux/bin"
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "You may also want to run this command to"
    elog "be able to run the mod:"
    elog
    elog "sudo chown -R <username> /usr/share/games/FNF-Sunday"
}
