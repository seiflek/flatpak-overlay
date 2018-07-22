# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils

DESCRIPTION="Tool to build flatpaks from source"
HOMEPAGE="http://flatpak.org/"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc yaml"

RDEPEND="
	>=dev-libs/glib-2.44
	>=app-emulation/flatpak-0.99.3
	>=sys-libs/libostree-2018.6
	>=net-libs/libsoup-2.4
	net-misc/curl
	>=dev-libs/elfutils-0.8.12
	>=dev-libs/libxml2-2.4
	>=dev-libs/json-glib-1.0
	yaml? (
		>=dev-libs/libyaml-0.1
	)
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.18.2
	doc? (
		>=app-text/docbook-xml-dtd-4.1.2
		app-text/xmlto
		dev-libs/libxslt
	)
"

src_configure() {
	local myeconfargs=(
		--disable-static
		$(use_with yaml)
		$(use_enable doc documentation)
		$(use_enable doc docbook-docs)
	)

	econf "${myeconfargs[@]}"

}
