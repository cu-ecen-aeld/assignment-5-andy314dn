# Assignment 7 Instructions

## Instruction breakdown

> Add a new package “ldd” to your assignment 5 base_external directory (base_external/package/ldd) which supports building and installing the misc-modules and scull components into the root filesystem.  Add this package to the image.

To complete the above step, follow these detailed instructions:

1. **Create the Package Directory**:
   - Navigate to your `base_external` directory in your assignment 5 repository.
   - Create a new directory named `ldd` within the `package` directory:

     ```bash
     mkdir -p base_external/package/ldd
     ```

2. **Create the Package Makefile**:
   - Inside the `ldd` directory, create a file named `Config.in` to define the package configuration.
        - This file should include options for enabling the `misc-modules` and `scull` components.
   - Create a `ldd.mk` file that contains the build instructions for your package.
        - This file should specify how to compile and install the `misc-modules` and `scull` components. Here’s a basic structure you can use:

     ```makefile
     LDD_VERSION = 1.0
     LDD_SOURCE = $(TOPDIR)/path/to/your/source

     define LDD_BUILD_CMDS
         $(MAKE) -C $(LDD_SOURCE) modules
     endef

     define LDD_INSTALL_CMDS
         $(INSTALL) -D -m 0755 $(LDD_SOURCE)/misc-modules.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/misc-modules.ko
         $(INSTALL) -D -m 0755 $(LDD_SOURCE)/scull.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/scull.ko
     endef

     $(eval $(call PACKAGE,ldd))
     ```

3. **Update the Buildroot Configuration**:
   - Open the `Config.in` file in the `ldd` directory and add the necessary configuration options. This will allow users to enable or disable the package when configuring Buildroot.
   - Example content for `Config.in`:

     ```makefile
     config BR2_PACKAGE_LDD
         bool "ldd package"
         help
           This package builds and installs misc-modules and scull components.
     ```

4. **Modify the Buildroot Menuconfig**:
   - To include your new package in the Buildroot configuration, you need to modify the main `Config.in` file located in the `package` directory to include your `ldd` package.
   - Add the following line to the appropriate section:

     ```makefile
     source "base_external/package/ldd/Config.in"
     ```

5. **Add the Package to the Image**:
   - In your Buildroot configuration, ensure that the `ldd` package is selected to be included in the final image. You can do this by running:

     ```bash
     make menuconfig
     ```

   - Navigate to the package selection menu and enable the `ldd` package.

6. **Build the Image**:
   - After making these changes, run the Buildroot build process to compile your image with the new package:

     ```bash
     make
     ```

7. **Verify Installation**:
   - Once the build is complete, check the output image to ensure that the `misc-modules` and `scull` components are correctly installed in the root filesystem.

By following these steps, you will successfully add the `ldd` package to your Buildroot assignment, enabling the building and installation of the `misc-modules` and `scull` components.
