# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pre-built libidn11 shared objects, needed for some mods to work"

HOMEPAGE="https://github.com/MagelessMayhem/Funkin/releases/tag/v0.2.7.1-DEPS"

SRC_URI="https://github.com/MagelessMayhem/Funkin/releases/download/v0.2.7.1-DEPS/libidn11.tar.gz"

S="${WORKDIR}/libidn11"

LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="~amd64"

src_install() {
	dodir "/usr/lib64/"
	insinto "/usr/lib64/"
	doins "libidn11/*"
}
