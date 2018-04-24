# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

PYTHON_COMPAT=( python2_7 )

DESCRIPTION="The Common Toolkit Application Launcher"
HOMEPAGE="https://commontk.org"

SRC_URI="https://github.com/commontk/AppLauncher/archive/b87f8d65f1f31947ba4c835cc2bdc6e25f0babca.zip -> ${P}.zip"

LICENSE="Apache 2.0"
KEYWORDS="~amd64 ~arm x86 ~amd64-linux ~x86-linux"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
"

DEPEND="${RDEPEND}"

src_unpack(){

	default

	mv ${WORKDIR}/* ${WORKDIR}/${P} || die
}

src_configure() {

	local mycmakeargs=()

	# General building options
	mycmakeargs+=(
		-DBUILD_TESTING=OFF
		-DCTK_BUILD_SHARED_LIBS=ON
	)

	# AppLauncher building options
	mycmakeargs+=(
		-DCTKAppLauncher_INSTALL_LauncherLibrary=ON
		-DCTKAppLauncher_VISIBILITY_HIDDEN=ON
		-DCTKAppLauncher_QT_VERSION=5
		-DQT_QMAKE_EXECUTABLE=/usr/lib64/qt5/bin/qmake
		-DCTKAppLauncher_INSTALL_LauncherLibrary=ON
	)

	cmake-utils_src_configure
}
