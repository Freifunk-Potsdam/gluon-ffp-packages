include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-setup-mode-wifi

include $(TOPDIR)/../package/gluon.mk

define Package/gluon-setup-mode-wifi
  TITLE:=Setup mode Wifi
  DEPENDS:=+gluon-setup-mode
endef

define Package/gluon-setup-mode-wifi/description
	Offline mode to perform basic setup in a secure manner over Wifi.
endef

define Package/gluon-setup-mode-wifi/install
	$(Gluon/Build/Install)
	$(LN) "/etc/init.d/wpad" "$(1)/lib/gluon/setup-mode/rc.d/S19wpad"
endef

$(eval $(call BuildPackageGluon,gluon-setup-mode-wifi))
