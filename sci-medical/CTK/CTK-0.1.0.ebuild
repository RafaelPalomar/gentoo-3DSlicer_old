# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils

DESCRIPTION="The Common Toolkit"

HOMEPAGE="https://commontk.org"

SRC_URI="https://github.com/commontk/CTK/archive/1e13d9806ae3dca9603c0d5e6e41181c74fc208e.zip -> ${P}.zip"

LICENSE="Apache 2.0"

KEYWORDS="~amd64"

SLOT="0"

DEPEND="
	sci-medical/DCMTK_CTK
	sci-libs/ITK_3DSlicer
	dev-qt/qttesting_CTK
	dev-python/PythonQt_CTK
"

PATCHES=(
	"${FILESDIR}"/${PN}-${PV}-include_missing_files.patch
)

src_unpack() {

	default

	mv ${WORKDIR}/* ${WORKDIR}/${P}
}

src_configure() {

	local mycmakeargs=()

	#General buiding options
	mycmakeargs+=(
		-DBUILD_TESTING=OFF
		-DCTK_BUILD_SHARED_LIBS=ON
		-DCTK_ENABLE_PluginFramework=OFF
		-DCTK_PLUGIN_org.commontk.plugingenerator.core=OFF
		-DCTK_PLUGIN_org.commontk.plugingenerator.ui=OFF
		-DCTK_USE_QTTESTING=ON
		-DCTK_USE_SYSTEM_DCMTK=ON
		-DCTK_USE_SYSTEM_VTK=ON
		-DCTK_USE_SYSTEM_ITK=ON
	)

	# CTK building options
	mycmakeargs+=(
		-DCTK_SUPERBUILD=OFF
		-DCTK_QT_VERSION=5
		-DQT_QMAKE_EXECUTABLE=/usr/lib64/qt5/bin/qmake
		-DCTK_ENABLE_DICOM=OFF
		-DCTK_ENABLE_Widgets=ON
		-DCTK_ENABLE_Python_Wrapping=ON
		-DCTK_LIB_PluginFramework=OFF
		-DCTK_LIB_Widgets=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTALL=OFF
		-DCTK_LIB_Visualization/VTK/Core=ON
		-DCTK_LIB_Visualization/VTK/Widgets=ON
		-DCTK_LIB_Visualization/VTK/Widgets_USE_TRANSFER_FUNCTION_CHARTS=ON
		-DCTK_LIB_Scripting/Python/Core=ON
		-DCTK_LIB_Scripting/Python/Widgets=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_USE_VTK=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTCORE=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTGUI=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTNETWORK=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTOPENGL=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTUITOOLS=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTWEBKIT=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTWEBKITWIDGETS=ON
		-DCTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTWIDGETS=ON
		-DCTK_BUILD_QTDESIGNER_PLUGINS=ON
	)

	#CTK modules
	mycmakeargs+=(
		-DCTK_LIB_DICOM/Core=ON
		-DCTK_LIB_DICOM/Widgets=ON
		-DCTK_LIB_ImageProcessing/ITK/Core=ON
		-DCTK_APP_ctkDICOM=ON
	)

	cmake-utils_src_configure
}
