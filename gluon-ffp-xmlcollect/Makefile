include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-ffp-xmlcollect
PKG_VERSION:=23.03
PKG_RELEASE:=1

include $(TOPDIR)/../package/gluon.mk

define Package/gluon-ffp-xmlcollect
  DEPENDS:=+gluon-core +libgluonutil +micrond
  TITLE:=Freifunk Potsdam Gluon XMLcollect
  URL:=http://github.com/freifunk-potsdam/gluon-ffp-packages
  PKGARCH:=all
endef

define Package/gluon-ffp-xmlcollect/description
  Freifunk Potsdam Gluon StatusXML collect script
endef

define Package/gluon-ffp-xmlcollect/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/ffp-xmlcollect.sh $(1)/usr/bin/ffp-xmlcollect.sh
	$(INSTALL_DIR) $(1)/lib/gluon/upgrade
	$(INSTALL_BIN) ./files/500-ffpxmlcollect $(1)/lib/gluon/upgrade/500-ffpxmlcollect
endef

$(eval $(call BuildPackageGluon,gluon-ffp-xmlcollect))
