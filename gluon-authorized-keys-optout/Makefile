include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-authorized-keys-optout

include ../gluon.mk

define Package/gluon-authorized-keys-optout
  TITLE:=Fill /etc/dropbear/authorized_keys from site.conf, skip keys which were previously disabled
  DEPENDS:=+gluon-core +gluon-lock-password
endef

$(eval $(call BuildPackageGluon,gluon-authorized-keys-optout))
