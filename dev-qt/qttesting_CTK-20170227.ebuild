# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils

DESCRIPTION="QtTesting framkework for CTK"

HOMEPAGE="https://github.com/commontk/QtTesting"

SRC_URI="https://github.com/commontk/QtTesting/archive/828b35edbbac6b08668809c84391003a2f513d1b.zip -> ${P}"

LICENSE="Paraview 1.2"

KEYWORDS="~amd64"

SLOT="0"

DEPEND="
	dev-qt/qtcore:5
"

RDEPEND="${DEPEND}"

src_unpack(){

	default

	mv ${WORKDIR}/* ${WORKDIR}/${P}
}

src_configure(){

	local mycmakeargs=()

	# General building options
	mycmakeargs+=(
		-DBUILD_TESTING=OFF
		-DCMAKE_CXX_FLAGS=-fPIC
		-DCMAKE_C_FLAGS=-fPIC
	)

	cmake-utils_src_configure
}
