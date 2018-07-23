# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils meson

DESCRIPTION="A server and user space API to deal with multimedia pipelines"
HOMEPAGE="https://pipewire.org/"
SRC_URI="https://github.com/PipeWire/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man doc gstreamer jack valgrind systemd"

CDEPEND="
	sys-apps/dbus
	media-libs/libv4l
	media-libs/alsa-lib
	virtual/libudev
	media-video/ffmpeg
	valgrind? (
		dev-util/valgrind
	)
	gstreamer? (
		>=dev-libs/glib-2.32.0
		>=media-libs/gstreamer-1.0
		>=media-libs/gst-plugins-base-1.0
		media-plugins/gst-plugins-xvideo
	)
	jack? (
		virtual/jack
	)
	systemd? (
		sys-apps/systemd
	)
"

DEPEND="${CDEPEND}
	>=dev-util/meson-0.36.0
	>=dev-util/ninja-1.5
	virtual/pkgconfig
	man? (
		app-doc/xmltoman
	)
	doc? (
		app-doc/doxygen
	)
"

src_configure() {
	local emesonargs=(
		-Denable_man=$(usex man true false)
		-Denable_docs=$(usex doc true false)
		-Denable_gstreamer=$(usex gstreamer true false)
	)

	meson_src_configure

}
