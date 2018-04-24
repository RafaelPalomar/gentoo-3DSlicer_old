# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="The DICOM Toolkit"

HOMEPAGE="http://dicom.offis.de/dcmtk.php.en"

SRC_URI="https://github.com/commontk/DCMTK/archive/53f8545c88aab47a08269c90039357fcf283ee58.zip -> ${P}.zip"

LICENSE="OFFIS"

KEYWORDS="~amd64 ~arm ~x86"

SLOT="0"

DEPEND="
	!sci-libs/dcmtk
	media-libs/libpng:*
	dev-libs/openssl:0
	media-libs/tiff:0
	dev-libs/libxml2:2
	sys-libs/zlib
"

RDEPEND="${RDEPEND}"

src_unpack(){

	default

	mv ${WORKDIR}/DCMTK-* ${WORKDIR}/${P} || die
}

src_configure() {
	local mycmakeargs=()

	mycmakeargs+=(
		-DBUILD_SHARED_LIBS=ON
		-DDCMTK_WITH_OPENSSL=ON
		-DDCMTK_WITH_PNG=ON
		-DDCMTK_WITH_THREADS=ON
		-DDCMTK_WITH_TIFF=ON
		-DDCMTK_WITH_XML=ON
		-DDCMTK_WITH_ZLIB=ON
		-DDCMTK_INSTALL_LIBDIR=$(get_libdir)
		-DDCMTK_ENABLE_BUILTIN_DICTIONARY=ON
		-DDCMTK_ENABLE_EXTERNAL_DICTIONARY=ON
		-DDCMTK_ENABLE_PRIVATE_TAGS=ON
		-DDCMTK_WITH_ICU=ON
		-DDCMTK_WITH_STDLIBC_ICONV=ON
		-DDCMTK_WITH_THREADS=ON
	)

	cmake-utils_src_configure
}
