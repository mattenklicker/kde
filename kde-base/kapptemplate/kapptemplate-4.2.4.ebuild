# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kapptemplate/kapptemplate-4.2.2.ebuild,v 1.2 2009/04/17 06:21:32 alexxy Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KAppTemplate - A shell script to create the necessary framework to develop KDE applications."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

# Fails, checked revision 810882.
RESTRICT="test"

src_prepare() {
	# Disable hardcoded kdepimlibs check - only 4.2 branch is affected
	sed -i -e 's/find_package(KdepimLibs REQUIRED)/macro_optional_find_package(KdepimLibs)/' \
		CMakeLists.txt || die "failed to disable kdepimlibs hardcoded check"

	kde4-meta_src_prepare
}
