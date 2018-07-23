# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils systemd

DESCRIPTION="GTK/GNOME backend for xdg-desktop-portal"
HOMEPAGE="https://github.com/flatpak/xdg-desktop-portal-gtk"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="X wayland systemd"

RDEPEND="
	>=dev-libs/glib-2.44[dbus]
	>=x11-libs/gtk+-3.14
	>=x11-misc/xdg-desktop-portal-0.11
	wayland? (
		>=x11-libs/gtk+-3.21.5:3[wayland]
	)
	X? (
		>=x11-libs/gtk+-3.14:3[X]
	)
	systemd? (
		sys-apps/systemd
	)
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.18.3
"

src_configure() {

	local myeconfargs=(
		--libexecdir=${EPREFIX}/usr/$(get_libdir)/libexec
	)

	if use systemd; then
		myeconfargs+=( --with-systemdsystemunitdir="$(systemd_get_systemunitdir)" )
	fi

	econf "${myeconfargs[@]}"

}
