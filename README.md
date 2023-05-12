OpenEmbedded/Yocto layer for Shairport-Sync
==================================================

This layer provides shairport-sync recipes for use with OpenEmbedded and/or Yocto.

This layer depends on:

* URI: git://git.openembedded.org/openembedded-core
  - branch: master
  - revision: HEAD

* URI: git://git.openembedded.org/meta-openembedded
  - layers: meta-oe
  - branch: master
  - revision: HEAD

Contributing
------------

The preferred way to contribute to this layer is to send GitHub pull requests or
report problems in GitHub's issue tracker.

Maintainers
-----------
* Balthazar DELIERS

Recipes
-------
**recipes-shairport/shairport-sync:**
Shairport Sync

Shairport Sync is an AirPlay and AirPlay 2 audio player.
It's made by Mike Brady, the project can be found here https://github.com/mikebrady/shairport-sync

Project source https://github.com/mikebrady/shairport-sync

**recipes-shairport/nqptp:**
NQPTP

nqptp is a daemon that monitors timing data from any PTP clocks – up to 64 – it sees on ports 319 and 320. It maintains records for each clock, identified by Clock ID and IP.

It is a companion application to Shairport Sync and provides timing information for AirPlay 2 operation.

Project source https://github.com/mikebrady/nqptp

**recipes-shairport/soxr:**
SoX

The SoX Resampler library `libsoxr' performs one-dimensional sample-rate conversion -- it may be used, for example, to resample PCM-encoded audio.

Project source https://github.com/chirlu/soxr