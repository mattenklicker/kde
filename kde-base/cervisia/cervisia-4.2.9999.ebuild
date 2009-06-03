# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-4.2.2.ebuild,v 1.2 2009/04/17 06:09:23 alexxy Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS=""
IUSE="debug +handbook"

RDEPEND="
	dev-util/cvs
"

src_prepare() {
	# Disable hardcoded kdepimlibs check - only 4.2 branch is affected
	sed -i -e 's/find_package(KdepimLibs REQUIRED)/macro_optional_find_package(KdepimLibs)/' \
		CMakeLists.txt || die "failed to disable kdepimlibs hardcoded check"

	kde4-meta_src_prepare
}
