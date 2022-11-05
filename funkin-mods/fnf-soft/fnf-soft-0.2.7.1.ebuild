# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod which encompasses an LGBT character"

HOMEPAGE="https://github.com/mattsodes1031/Softmod-Public"

SRC_URI="https://github.com/MagelessMayhem/FNF-Soft-Gentoo/archive/refs/tags/v0.2.7.1-soft.tar.gz"

S="${WORKDIR}/FNF-Soft-Gentoo-0.2.7.1-soft"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
        media-sound/pulseaudio
        x11-libs/libX11
        =dev-lang/haxe-9999
"

DEPEND="${RDEPEND}"

src_compile() {
    haxelib setup /var/tmp/portage/.local/share/haxe/lib
    cd ${S}
    haxelib run lime build linux -verbose
}
src_install() {
    keepdir "/usr/share/games/FNF-Soft"
    insinto "/usr/share/games/FNF-Soft"
    doins -r "export/release/linux/bin"
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "You may also want to run this command to"
    elog "be able to run the mod:"
    elog
    elog "sudo chown -R <username> /usr/share/games/FNF-Soft"
}
