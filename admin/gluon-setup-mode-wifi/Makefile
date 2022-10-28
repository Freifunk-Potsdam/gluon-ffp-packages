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

init_links := \
	K21wpad \
	S21wpad

define Package/gluon-setup-mode-wifi/install
	$(Gluon/Build/Install)
	for link in $(init_links); do \
		$(LN) "/etc/init.d/$$$${link:3}" "$(1)/lib/gluon/setup-mode/rc.d/$$$${link}"; \
	done
endef

$(eval $(call BuildPackageGluon,gluon-setup-mode-wifi))
