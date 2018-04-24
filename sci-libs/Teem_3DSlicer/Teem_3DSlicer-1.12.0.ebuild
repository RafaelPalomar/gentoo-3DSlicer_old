# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

DESCRIPTION="Set of libraries for representing, processing and visualizing scientific raster data. This is the version maintained by and for the 3D Slicer project (https://github.com/Slicer/teem)"

HOMEPAGE="https://teem.sourceforge.net"

SRC_URI="https://github.com/Slicer/teem/archive/e4746083c0e1dc0c137124c41eca5d23adf73bfa.zip -> ${P}.zip"

LICENSE="LGPL-2.1"

KEYWORDS="~amd64"

SLOT="0"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-Fix_install_dirs.patch
	"${FILESDIR}"/${P}-Fix_install_dirs2.patch
	)


src_unpack(){

	default

	mv ${WORKDIR}/* ${WORKDIR}/${P}
}

src_configure() {

	local mycmakeargs=()

	mycmakeargs+=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTING=OFF
		-DTEEM_LIB_INSTALL_DIR=$(get_libdir)
	)

	cmake-utils_src_configure
}
