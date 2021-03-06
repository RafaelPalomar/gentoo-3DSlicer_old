# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils

DESCRIPTION="The Visualization Toolkit"
HOMEPAGE="https://www.vtk.org/"

SRC_URI="https://github.com/Slicer/VTK/archive/887c5065ec2220be04b105ce1d966c5162e729af.zip -> ${P}.zip"

LICENSE="BSD LGPL-2"
KEYWORDS="~amd64 ~arm x86 ~amd64-linux ~x86-linux"
SLOT="0"

RDEPEND="
	dev-libs/expat
	dev-libs/jsoncpp
	dev-libs/libxml2:2
	>=media-libs/freetype-2.5.4
	media-libs/libpng:0=
	media-libs/libtheora
	media-libs/mesa
	media-libs/tiff:0
	sci-libs/exodusii
	sci-libs/hdf5:=
	sci-libs/netcdf-cxx:3
	sys-libs/zlib
	virtual/jpeg:0
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	!sci-libs/vtk
	dev-qt/qtx11extras"

DEPEND="${RDEPEND}"

src_unpack() {
	default
	mv VTK-*/ ${P}
}

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {

	local mycmakeargs=()

	# General building options
	mycmakeargs+=(
		-DBUILD_TESTING=OFF
		-DBUILD_SHARED_LIBS=ON
		-DVTK_INSTALL_LIBRARY_DIR=$(get_libdir)
	)

	# VTK building options
	mycmakeargs+=(
		-DVTK_RENDERING_BACKEND=OpenGL2
		-DVTK_WRAP_PYTHON=ON
		-DVTK_Group_Rendering=ON
		-DVTK_ENABLE_KITS=ON
		-DVTK_ENABLEVTKPYTHON=ON
	)

	#VTK modules
	mycmakeargs+=(
		-DModule_vtkIOInfovis=ON
		-DModule_vtkIOPLY=ON
		-DModule_vtkImagingMath=ON
		-DModule_vtkImagingMorphological=ON
		-DModule_vtkImagingStatistics=ON
		-DModule_vtkImagingStencil=ON
		-DModule_vtkRenderingQt=ON
		-DModule_vtkTestingRendering=ON
		-DModule_vtkViewsQt=ON
		-DModule_vtkWrappingPyhtonCore=ON
		-DModule_vtkGUISupportQtOpenGL=ON
		-DModule_vtkGUISupportQtSQL=ON
		-DModule_vtkRenderingFreeTypeFontConfig=ON
	)


	cmake-utils_src_configure
}
