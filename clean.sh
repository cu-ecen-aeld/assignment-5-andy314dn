#!/bin/bash
# Script to run make distclean from the buildroot directory

printf "Perform \e[1;31mmake distclean\e[0m for Buildroot\n"
make -C buildroot distclean
