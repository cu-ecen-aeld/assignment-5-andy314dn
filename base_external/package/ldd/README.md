# Assignment 7 Instructions

## Instruction breakdown

Note: I only put here instructions for complicated steps.

### Step 1d

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

### Step 1e

> Use a rootfs overlay in buildroot to add an init module script named `"S98lddmodules"`.
Be sure to specify a **relative path in buildroot menuconfig to support builds outside your working directory**.
For instance, use `../base_external/rootfs_overlay` to locate in a `rootfs_overlay` directory you add to your `base_external` directory.
Add init scripts to the appropriate paths within this overlay to:

> * i. Perform operations on startup to load the scull driver and on shutdown to unload.
See scull_load and scull_unload scripts for reference and customize these as necessary.

> * ii. Perform operations on startup to load the faulty driver and on shutdown to unload.
See module_load and module_unload scripts for reference and customize these as necessary.

> * iii. Run modprobe on the hello module to load on startup and use rmmod to remove on shutdown.

To complete this step, you will need to create a root filesystem (rootfs) overlay in Buildroot and add an init script named `S98lddmodules`. Here’s a the guide:

#### Step 1: Create the Overlay Directory

1. **Navigate to your Buildroot directory**.
2. **Create a new directory for the rootfs overlay**:

   ```bash
   mkdir -p base_external/rootfs_overlay
   ```

#### Step 2: Create the Init Script

1. **Inside the `rootfs_overlay` directory**, create the init script:

   ```bash
   touch base_external/rootfs_overlay/S98lddmodules
   ```

2. **Open the `S98lddmodules` file in a text editor** and add the following content:

   ```bash
   #!/bin/sh
   ### BEGIN INIT INFO
   # Provides:          lddmodules
   # Required-Start:    $local_fs $network
   # Required-Stop:     $local_fs $network
   # Default-Start:     2 3 4 5
   # Default-Stop:      0 1 6
   # Short-Description: Load ldd kernel modules
   ### END INIT INFO

   case "$1" in
       start)
           echo "Loading scull driver..."
           modprobe scull
           echo "Loading faulty driver..."
           modprobe faulty
           echo "Loading hello module..."
           modprobe hello
           ;;
       stop)
           echo "Unloading hello module..."
           rmmod hello
           echo "Unloading faulty driver..."
           rmmod faulty
           echo "Unloading scull driver..."
           rmmod scull
           ;;
       *)
           echo "Usage: $0 {start|stop}"
           exit 1
           ;;
   esac

   exit 0
   ```

#### Step 3: Make the Script Executable

1. **Change the permissions of the script** to make it executable:

   ```bash
   chmod +x base_external/rootfs_overlay/S98lddmodules
   ```

#### Step 4: Configure Buildroot

1. **Run `make menuconfig`** in your Buildroot directory.
2. **Navigate to** `System configuration` -> `Root filesystem overlay directories`.
3. **Add the relative path** to your overlay directory:

   ```txt
   ../base_external/rootfs_overlay
   ```

#### Step 5: Build Your Image

1. **Run the Buildroot build process**:

   ```bash
   make
   ```

#### Step 6: Verify the Init Script

1. **After building**, check the generated root filesystem to ensure that the `S98lddmodules` script is present in the appropriate init.d directory (usually `/etc/init.d/`).
2. **Test the script** by booting your image and checking if the modules load and unload correctly during startup and shutdown.

#### Additional Notes

- Make sure that the module names (`scull`, `faulty`, `hello`) match the actual names of the modules you have built.
- You can customize the echo statements or add logging as needed for debugging purposes.

This should help you set up the init script correctly in your Buildroot environment.
