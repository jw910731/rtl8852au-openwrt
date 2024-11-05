include $(TOPDIR)/rules.mk

PKG_NAME:=rtl8852au
PKG_RELEASE=1

PKG_LICENSE:=
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/lwfinger/rtl8852au.git
PKG_MIRROR_HASH:=a6f0293fa6c41610f8c5dba46fa211f25c10841a053cd78dacd703819047603e
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-06
PKG_SOURCE_VERSION:=865ab0fa91471d595c283d2f3db323f7f15455f5

PKG_MAINTAINER:=lwfinger <Larry.Finger@lwfinger.net>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

NOSTDINC_FLAGS = \
	-I$(PKG_BUILD_DIR)/include \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-include backport/backport.h
NOSTDINC_FLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_RADIO_WORK -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT -DBUILD_OPENWRT

define KernelPackage/rtl8852au
  SUBMENU:=Wireless Drivers
  TITLE:=Driver for Realtek 8852 AU devices
  DEPENDS:=+@DRIVER_11AC_SUPPORT +@DRIVER_11AX_SUPPORT +kmod-mac80211 +kmod-cfg80211
  FILES:=\
	  $(PKG_BUILD_DIR)/8852au.ko
  AUTOLOAD:=$(call AutoLoad,60,8852au)
  PROVIDES:=kmod-rtl8852au
endef

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
    CONFIG_RTL8852AU=m \
    SUBARCH="$(LINUX_KARCH)" \
    TopDIR=$(PKG_BUILD_DIR) \
    M="$(PKG_BUILD_DIR)" \
    NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		modules
endef

$(eval $(call KernelPackage,rtl8852au))
