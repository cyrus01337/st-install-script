#!/usr/bin/env bash
set -e

INSTALLATION_DIRECTORY="/opt/st"
CONFIGURATION_FILE="$INSTALLATION_DIRECTORY/config.def.h"

sudo mkdir --from "$USER:$USER" --mode 711 $INSTALLATION_DIRECTORY || true
git clone --single-branch --depth 1 https://git.suckless.org/st $INSTALLATION_DIRECTORY
sed -i "s/Liberation Mono:pixel/FantasqueSansM Nerd Font:/" $CONFIGURATION_FILE && \
    sed -i "s/\/bin\/sh/\/usr\/bin\/bash/" $CONFIGURATION_FILE && \
    sed -i -E "s/(tabspaces = )8/\14/" $CONFIGURATION_FILE

for patch in patches/*.diff; do
    echo ""
    echo "Patching $patch..."
    echo ""

    patch -Ni $patch
done

sudo make clean install
