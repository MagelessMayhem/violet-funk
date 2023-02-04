# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pre-built libvlccore7 libraries, needed by some mods"
HOMEPAGE="https://github.com/videolan/vlc"
SRC_URI="https://github.com/MagelessMayhem/hxCodec/releases/download/v2.5.1/libvlccore7.tar.gz"

S="${WORKDIR}/libvlccore7"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	# Symlinking on the fly since it's generally easier

	dodir "/usr/lib64"
	insinto "/usr/lib64"
	doins "${S}/libvlccore.so.7.0.0"
	dosym "/usr/lib64/libvlccore.so.7.0.0" "/usr/lib64/libvlccore.so.7"
}
