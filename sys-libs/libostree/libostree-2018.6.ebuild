# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils systemd


DESCRIPTION="Operating system and container binary deployment and upgrades"
HOMEPAGE="https://github.com/ostreedev/ostree"
SRC_URI="https://github.com/ostreedev/ostree/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"

IUSE="doc +man selinux +curl +soup systemd avahi +openssl gnutls http2 introspection libmount"

KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/glib-2.40
	sys-libs/zlib
	>=app-arch/xz-utils-5.1
	>=sys-fs/fuse-2.9.2
	>=app-crypt/gpgme-1.1.8
	>=app-arch/libarchive-2.8.0
	selinux? (
		>=sys-libs/libselinux-2.1.13
	)
	openssl? (
		>=dev-libs/openssl-1.0.1
	)
	gnutls? (
		>=net-libs/gnutls-3.5
	)
	libmount? (
		>=sys-apps/util-linux-2.23
	)
	avahi? (
		>=net-dns/avahi-0.6.31
	)
	systemd? (
		sys-apps/systemd
	)
	curl? (
		>=net-misc/curl-7.29
	)
	soup? (
		>=net-libs/libsoup-2.40
	)
"

DEPEND="${RDEPEND}
	sys-devel/bison
	virtual/pkgconfig
	sys-fs/e2fsprogs
	man? (
		dev-libs/libxslt
	)
	introspection? (
		>=dev-libs/gobject-introspection-1.34
	)
	doc? (
		>=dev-util/gtk-doc-1.15
	)
"

src_configure() {

	local myeconfargs=(
		--disable-static
		--libexecdir="${EPREFIX}/usr/$(get_libdir)/libexec"
		--with-libarchive
		--without-dracut
		--without-mkinitcpio
		$(use_with selinux)
		$(use_with avahi)
		$(use_with libmount)
		$(use_with systemd libsystemd)
		$(use_enable man)
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
		$(use_enable http2)
	)

	if use openssl; then
		myeconfargs+=( --with-crypto=openssl )
	elif use gnutls; then
		myeconfargs+=( --with-crypto=gnutls )
	fi

	if use systemd; then
		myeconfargs+=( --with-systemdsystemunitdir="$(systemd_get_systemunitdir)" )
	fi

	if use soup; then
		myeconfargs+=( $(use_with soup) )
	elif use curl; then
		myeconfargs+=( $(use_with curl) )
	fi

	econf "${myeconfargs[@]}"

}
