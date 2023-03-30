include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-preserve-extra-devices

include $(TOPDIR)/../package/gluon.mk

define Package/gluon-preserve-extra-devices
  TITLE:=Preserve extra devices added to the wan and client interfaces
  DEPENDS:=+gluon-core
endef

$(eval $(call BuildPackageGluon,gluon-preserve-extra-devices))
