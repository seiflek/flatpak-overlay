# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit kde5

DESCRIPTION="A backend implementation for xdg-desktop-portal using Qt/KF5"
HOMEPAGE="https://github.com/KDE/xdg-desktop-portal-kde"
SRC_URI="mirror://kde/stable/plasma/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep extra-cmake-modules)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwayland)
	$(add_qt_dep qtcore)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtprintsupport)
"

RDEPEND="${DEPEND}
	>=x11-misc/xdg-desktop-portal-0.11
	>=app-emulation/flatpak-0.99.3
"
