LDD_VERSION = '0169c9cd1703d735407aacb556e63bf18c1ec10d'
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-andy314dn.git'
LDD_SITE_METHOD = git

# build the misc-modules kernel modules
define LDD_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules
endef

define LDD_INSTALL_CMDS
	insmod $(@D)/misc-modules/hello.ko
endef

$(eval $(generic-package))
