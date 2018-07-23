# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils systemd

DESCRIPTION="A portal frontend service for Flatpak"
HOMEPAGE="http://flatpak.org/"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc systemd pipewire"

RDEPEND="
	>=app-emulation/flatpak-0.10.3
	dev-libs/glib:2[dbus]
	sys-fs/fuse
	pipewire? (
		>=media-gfx/pipewire-0.2.0
	)
	systemd? (
		sys-apps/systemd
	)
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.18.3
	doc? (
		app-text/xmlto
	)
"

src_configure() {
	local myeconfargs=(
		--libexecdir="${EPREFIX}/usr/$(get_libdir)/libexec"
		$(use_enable pipewire)
		$(use_enable doc docbook-docs)
	)

	if use systemd; then
		myeconfargs+=( --with-systemdsystemunitdir="$(systemd_get_systemunitdir)" )
	fi

	econf "${myeconfargs[@]}"

}
