# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( pytyhon2_7 )

inherit cmake-utils multilib

DESCRIPTION="Software platform for medical image informatics, image processing, and three-dimensional visualization"

HOMEPAGE="https://www.slicer.org"

SRC_URI="https://github.com/Slicer/Slicer/archive/v4.8.1.zip -> ${P}.zip"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~amd64"

DEPEND="\
		dev-libs/openssl
		app-arch/libarchive
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		dev-qt/qtpositioning:5
		dev-qt/qtxmlpatterns:5
		dev-python/couchdb-python
		dev-python/smmap
		dev-python/gitdb
		dev-python/git-python
		dev-python/wheel
		dev-python/PyGithub
		dev-python/nose
		=sci-libs/VTK_3DSlicer-9.0.0
		sci-medical/CTK
		sci-libs/Teem_3DSlicer
		sci-medical/3DSlicerExecutionModel
		sci-libs/jqPlot
		sci-medical/CTKAppLauncher
 "

RDEPEND="${DEPEND}"


PATCHES=(
	"${FILESDIR}"/${P}-FindPythonQt.patch
	"${FILESDIR}"/${P}-Fix_cxx_standard_11.patch
	"${FILESDIR}"/${P}-vtk_libs_for_mrml_core.patch
	"${FILESDIR}"/${P}-Fix_QtTesting_include_dirs.patch
	"${FILESDIR}"/${P}-Find_itk_qSlicerBaseQtCore.patch
	"${FILESDIR}"/${P}-Fix_include_directories_for_QtTesting.patch
	"${FILESDIR}"/${P}-Fix_PythonQt_include_dirs.patch
	"${FILESDIR}"/${P}-Fix_including_w32_files_in_non-windows.patch
	"${FILESDIR}"/${P}-Fix_PythonQt_include_dirs_2.patch
	"${FILESDIR}"/${P}-Fix_include_dirs_for_SlicerApp.patch
	"${FILESDIR}"/${P}-Fix_slicer_configuration_python.patch
	"${FILESDIR}"/${P}-Fix_no_install_DCMTK.patch
	"${FILESDIR}"/${P}-Remove_CPack_from_LastConfigureStep.patch
)


src_unpack(){

	default

	mv ${WORKDIR}/Slicer-${PV} ${WORKDIR}/${P} || die
}

src_prepare() {
	mkdir ${WORKDIR}/${P}/Utilities/CMake
	cp "${FILESDIR}"/FindPythonQt.cmake ${WORKDIR}/${P}/Utilities/CMake

	cmake-utils_src_prepare
}

src_configure(){

	local mycmakeargs=()

	mycmakeargs+=(
		-DBUILD_TESTING=OFF
		-DSlicer_SUPERBUILD=OFF
		-DSlicer_REQUIRED_QT_VERSION=5.9.4
		-DSlicer_VTK_RENDERING_BACKEND=OpenGL2
		-DSlicer_VTK_VERSION_MAJOR=9
		-DTeem_DIR=/usr/$(get_libdir)
		-DSlicer_BUILD_CLI_SUPPORT=OFF
		-DSlicer_BUILD_EXTENSIONMANAGER_SUPPORT=OFF
		-DjqPlot_DIR=/usr/share/jqPlot
		-DSlicer_INSTALL_DEVELOPMENT=ON
		-DSlicer_USE_PYTHONQT=OFF
		-DSlicer_USE_QtTesting=OFF
		-DSlicer_USE_CTKAPPLAUNCHER=OFF
	)

	cmake-utils_src_configure
}
