include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-web-ffp-backbone-wifi

include $(TOPDIR)/../package/gluon.mk

define Package/gluon-web-ffp-backbone-wifi
  DEPENDS:=+gluon-web-admin +gluon-ffp-backbone-wifi
  TITLE:=UI for configuring the Freifunk Potsdam 5Ghz Backbone connection
endef

$(eval $(call BuildPackageGluon,gluon-web-ffp-backbone-wifi))
