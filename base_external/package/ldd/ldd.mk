LDD_VERSION = '0169c9cd1703d735407aacb556e63bf18c1ec10d'
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-andy314dn.git'
LDD_SITE_METHOD = git

# build the misc-modules kernel modules
define LDD_BUILD_CMDS
    $(MAKE) -C $(@D)/misc-modules
    $(MAKE) -C $(@D)/scull
endef

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/misc-modules/hello.ko  $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)
    $(INSTALL) -m 0755 $(@D)/scull/scull.ko         $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)
endef

$(eval $(generic-package))
