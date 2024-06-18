include $(TOPDIR)/rules.mk

PKG_NAME:=ffp-fastd-restart

include $(TOPDIR)/../package/gluon.mk

define Package/ffp-fastd-restart
  TITLE:=Restarts fastd once a day
  DEPENDS:=+gluon-core +gluon-mesh-vpn-fastd
endef

$(eval $(call BuildPackageGluon,ffp-fastd-restart))
