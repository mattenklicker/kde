# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre1"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"
SRC_URI="http://ktorrent.org/downloads/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE="+bwscheduler +infowidget +ipfilter +logviewer +mediaplayer +scanfolder +search +stats +upnp webinterface zeroconf"

DEPEND="app-crypt/qca:2
	app-misc/strigi
	dev-libs/gmp
	sys-devel/gettext"
RDEPEND="${DEPEND}
	infowidget? ( >=dev-libs/geoip-1.4.4 )
	ipfilter? (
		|| ( kde-base/kdebase-kioslaves:${SLOT}
			kde-base/kdelibs:${SLOT} ) )
	zeroconf? ( kde-base/kdnssd:${SLOT} )"

LANGS="ar be bg ca da de el en_GB eo es et eu fi fr ga gl hi hu it ja km lt lv
nb nds nl nn oc pl pt pt_BR ro ru se sk sl sv tr uk zh_CN zh_TW"
for LANG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LANG}"
done

# fix install PREFIX
PREFIX="${KDEDIR}"

src_unpack() {
	local LANG

	unpack ${A}
	cd "${S}"
	# take care of linguas
	comment_all_add_subdirectory po/ || die "sed to remove all linguas failed."
	for LANG in ${LINGUAS}; do
		sed -i \
			-e "/add_subdirectory(\s*${LANG}\s*)\s*$/ s/^#DONOTCOMPILE //" \
			po/CMakeLists.txt || die "sed to uncomment ${LANG} failed."
	done
}

src_compile() {
	local mycmakeargs

	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}
		-DENABLE_DHT_SUPPORT=ON
		$(cmake-utils_use_enable bwscheduler BWSCHEDULER_PLUGIN)
		$(cmake-utils_use_enable infowidget INFOWIDGET_PLUGIN)
		$(cmake-utils_use_with infowidget SYSTEM_GEOIP)
		$(cmake-utils_use_enable ipfilter IPFILTER_PLUGIN)
		$(cmake-utils_use_enable logviewer LOGVIEWER_PLUGIN)
		$(cmake-utils_use_enable mediaplayer MEDIAPLAYER_PLUGIN)"
		$(cmake-utils_use_enable scanfolder SCANFOLDER_PLUGIN)
		$(cmake-utils_use_enable search SEARCH_PLUGIN)
		$(cmake-utils_use_enable stats STATS_PLUGIN)
		$(cmake-utils_use_enable upnp UPNP_PLUGIN)
		$(cmake-utils_use_enable webinterface WEBINTERFACE_PLUGIN)
		$(cmake-utils_use_enable zeroconf ZEROCONF_PLUGIN)
	kde4-base_src_compile
}
