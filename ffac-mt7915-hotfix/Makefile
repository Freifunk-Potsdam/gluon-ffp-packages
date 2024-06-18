# SPDX-FileCopyrightText: 2024 Felix Baumann (FFAC)
# SPDX-License-Identifier: MIT
include $(TOPDIR)/rules.mk

PKG_NAME:=ffac-mt7915-hotfix
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_LICENSE:=MIT

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(TOPDIR)/../package/gluon.mk

define Package/$(PKG_NAME)
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=reload mt7915-firmware twice a day
  DEPENDS:=@(TARGET_mediatek_filogic||TARGET_ramips_mt7621) kmod-mt7915e +gluon-core +micrond
  MAINTAINER:=Freifunk Aachen <kontakt@freifunk-aachen.de>
endef

define Build/Prepare
  mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
  $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
