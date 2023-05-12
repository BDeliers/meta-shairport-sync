SUMMARY = "Not Quite PTP"
DESCRIPTION = "nqptp is a daemon that monitors timing data from any PTP clocks it sees on ports 319 and 320. It maintains records for each clock, identified by Clock ID and IP."
HOMEPAGE = "https://github.com/mikebrady/nqptp"

LICENSE  = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS += "initscripts"

SRCREV = "5672c33983ab0125cd067be2d004598c49bf45c3"
PV = "+git${SRCPV}"
SRC_URI = "git://github.com/mikebrady/nqptp.git;branch=main;protocol=https \
           file://nqptp.d"

S = "${WORKDIR}/git"

inherit autotools update-rc.d

INITSCRIPT_NAME = "nqptp"

do_install:append() {
	install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/nqptp.d ${D}${sysconfdir}/init.d/nqptp
}