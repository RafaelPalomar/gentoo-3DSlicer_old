# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

DESCRIPTION="Execution model library for 3D Slicer"

SRC_URI="https://github.com/Slicer/SlicerExecutionModel/archive/1d3e9a226bd594f23733993c16c337ba60077bc5.zip -> ${P}.zip"

LICENSE=""

SLOT="0"

KEYWORDS="~amd64"

DEPEND="
	sci-libs/ITK_3DSlicer
"
RDEPEND="${RDEPEND}"

src_unpack(){

	default

	mv ${WORKDIR}/* ${WORKDIR}/${P} || die
}

src_configure(){

	local mycmakeargs=()

	#General buiding options
	mycmakeargs+=(
		-DBUILD_TESTING=OFF
		-DBUILD_SHARED_LIBS=ON
	)

	#SlicerExecutionModel Paths
	mycmakeargs+=(
		-DSlicerExecutionModel_INSTALL_BIN_DIR=/usr/bin
		-DSlicerExecutionModel_INSTALL_LIB_DIR=/usr/$(get_libdir)
		-DSlicerExecutionModel_INSTALL_NO_DEVELOPMENT=/usr/$(get_libdir)
	)
	cmake-utils_src_configure
}
