# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="A KDE game similiar to Mahjongg"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="
	>=kde-base/libkmahjongg-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
