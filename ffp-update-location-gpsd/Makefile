# SPDX-FileCopyrightText: 2026 Sven Reißland, seth0r
# SPDX-License-Identifier: MIT
include $(TOPDIR)/rules.mk

PKG_NAME:=ffp-update-location-gpsd
PKG_VERSION:=26.06
PKG_RELEASE:=1

PKG_LICENSE:=MIT

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  TITLE:=Use local GPS daemon to update location from it
  DEPENDS:=+micrond +gpsd +gpsd-clients
endef

define Package/$(PKG_NAME)/description
  This package updates the gluon-node-info location based on the NMEA output of the local GPS daemon.
endef

$(eval $(call BuildPackageGluon,$(PKG_NAME)))
