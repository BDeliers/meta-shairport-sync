SUMMARY = "AirPlay and AirPlay 2 audio player"
DESCRIPTION = "Shairport Sync is an AirPlay audio player for Linux and FreeBSD. It plays audio streamed from Apple devices and from AirPlay sources such as OwnTone (formerly forked-daapd)."
HOMEPAGE = "https://github.com/mikebrady/shairport-sync"

LICENSE  = "MIT"
LIC_FILES_CHKSUM = "file://LICENSES;md5=9f329b7b34fcd334fb1f8e2eb03d33ff"

inherit autotools pkgconfig update-rc.d

DEPENDS += "avahi alsa-lib popt libconfig soxr libplist libsodium libgcrypt ffmpeg initscripts xxd-native"
RDEPENDS:${PN} += "nqptp"

SRCREV = "a732f5d3060121601ef0814815b5bb4d07925965"
PV = "+git${SRCPV}"
SRC_URI = "git://github.com/mikebrady/shairport-sync.git;branch=master;protocol=https \
           file://shairport-sync.d"

S = "${WORKDIR}/git"

EXTRA_OECONF += "--sysconfdir=/etc --with-alsa --with-soxr --with-avahi --with-ssl=openssl --with-airplay-2"

INITSCRIPT_NAME = "shairport-sync"

do_install:append() {
	install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/shairport-sync.d ${D}${sysconfdir}/init.d/shairport-sync
}