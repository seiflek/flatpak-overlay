# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools

DESCRIPTION="Linux application sandboxing and distribution framework"
HOMEPAGE="http://flatpak.org/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc gtk kde +introspection +policykit +seccomp +xauth +system-bubblewrap"

CDEPEND="
	>=sys-libs/libostree-2018.6
	>=dev-libs/glib-2.44:2
	>=net-libs/libsoup-2.4
	>=dev-libs/appstream-glib-0.5.10
	>=dev-libs/libxml2-2.4
	sys-apps/dbus
	>=dev-libs/json-glib-1.0
	sys-libs/libcap
	>=app-arch/libarchive-2.8.0
	>=app-crypt/gpgme-1.1.8
	system-bubblewrap? (
		>=sys-apps/bubblewrap-0.2.1
	)
	xauth? (
		x11-apps/xauth
		x11-libs/libXau
	)
	policykit? ( 
		>=sys-auth/polkit-0.98
	)
	seccomp? (
		sys-libs/libseccomp
	)
"

DEPEND="${CDEPEND}
	>=sys-devel/automake-1.13.4
	dev-util/intltool
	>=sys-devel/gettext-0.18.2
	virtual/pkgconfig
	>=dev-util/gdbus-codegen-2.0
	sys-devel/bison
	introspection? (
		>=dev-libs/gobject-introspection-1.40
	)
	doc? (
		>=dev-util/gtk-doc-1.20
		>=app-text/docbook-xml-dtd-4.1.2
		dev-libs/libxslt 
		app-text/docbook-xsl-stylesheets
	)
"

PDEPEND="${CDEPEND}
	gtk? (
		>=x11-misc/xdg-desktop-portal-0.11
		>=x11-misc/xdg-desktop-portal-gtk-0.11
	)
	kde? (
		>=x11-misc/xdg-desktop-portal-0.11
		>=kde-plasma/xdg-desktop-portal-kde-5.12.5
	)
"

src_configure() {

	local myeconfargs=(
		--disable-static
		--libexecdir="${EPREFIX}/usr/$(get_libdir)/libexec"
		--enable-sandboxed-triggers
		--with-priv-mode=setuid
		--localstatedir="${EPREFIX}/var"
		$(use_with system-bubblewrap)
		$(use_enable xauth)
		$(use_enable seccomp)
		$(use_enable doc documentation)
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
		$(use_enable policykit system-helper)
	)

	econf "${myeconfargs[@]}"

}
