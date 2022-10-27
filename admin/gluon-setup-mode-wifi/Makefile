# Copyright (C) 2012 Nils Schneider <nils at nilsschneider.net>
# This is free software, licensed under the Apache 2.0 license.

include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-setup-mode-wifi

include ../gluon.mk

define Package/gluon-setup-mode
  TITLE:=Setup mode Wifi
  DEPENDS:=+gluon-setup-mode
endef

define Package/gluon-setup-mode-wifi/description
	Offline mode to perform basic setup in a secure manner over Wifi.
endef

define Package/gluon-setup-mode-wifi/install
	$(Gluon/Build/Install)
endef

$(eval $(call BuildPackageGluon,gluon-setup-mode-wifi))
