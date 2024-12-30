#!/bin/bash

#
# This script will print the ebuilds installed packages on the system Gentoo.
#
# Install dependencies
# emerge -va app-portage/gentoolkit
#
# e.g.
# <<<ebuild>>>
# app-portage/gentoolkit 0.4.0-r1 1
# app-portage/portage-utils 0.92 1
# app-portage/repoman 2.3.10 1
#
# TODO: Pending adding package size, now showing 1.
#

echo "<<<ebuild>>>"
equery -C list "*" --format='$name $fullversion $mask2 1' | awk '
{
    key = $1  # Usa el nombre del paquete como clave
    version = $2  # Versión completa
    if (!seen[key] || version > seen[key]) {
        seen[key] = version
        line[key] = $0
    }
}
END {
    for (k in line) {
        print line[k]
    }
}'