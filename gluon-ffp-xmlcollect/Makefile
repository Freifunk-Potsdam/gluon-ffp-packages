include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-ffp-xmlcollect
PKG_VERSION:=22.10
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
	$(Gluon/Build/Install)
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/ffp-xmlcollect.sh $(1)/usr/bin/ffp-xmlcollect.sh
endef

$(eval $(call BuildPackageGluon,gluon-ffp-xmlcollect))
