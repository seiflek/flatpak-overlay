# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils bash-completion-r1

DESCRIPTION="Unprivileged sandboxing tool"
HOMEPAGE="https://github.com/projectatomic/bubblewrap"
SRC_URI="https://github.com/projectatomic/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man selinux +bash-completion"

CDEPEND="
	sys-libs/libcap
	selinux? (
		>=sys-libs/libselinux-2.1.9
	)
"

DEPEND="${CDEPEND}
	virtual/pkgconfig
	man? (
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
"

src_configure() {

	local myeconfargs=(
		--with-priv-mode=setuid
		$(use_enable selinux)
		$(use_enable man)
	)

	if use bash-completion; then
		myeconfargs+=( --with-bash-completion-dir="$(get_bashcompdir)" )
	else
		myeconfargs+=( --with-bash-completion-dir=no )
	fi

	econf "${myeconfargs[@]}"

}
