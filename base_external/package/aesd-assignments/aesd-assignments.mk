
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# Reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 'd0ae0a427a66c67a9675720da43bffbe6d30fe55'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-andy314dn.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES
# # In case we want to refer to Assignment 3 locally
# AESD_ASSIGNMENTS_OVERRIDE_SRCDIR ?= <path_to_>/assignments-3-and-later-andy314dn
# at Buildroot directory:
# make aesd-assignments-rebuild

# Build: finder-app (assignment 4)
# Build: aesdsocket (assignment 5)
define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

# Add your writer, finder and finder-test utilities/scripts to the installation steps below
# Install aesdsocket executable to /usr/bin
# Install your aesdsocket-start-stop script to /etc/init.d/S99aesdsocket
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh      $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer         $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket         $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))
