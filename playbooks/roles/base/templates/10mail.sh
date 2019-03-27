#!/usr/bin/env bash

set -e

# Send mail if /usr/bin/mutt exists
[ -x /usr/bin/mutt ] || (echo "Your system does not have /usr/bin/mutt. Install the mutt package" ; exit 0)

input="${1}"
shift

/usr/bin/mutt -H - "${3}" <<EOF
From: {{ admin_addr_from }}
To: ${3}
Subject: ${2}


`cat ${input}`
EOF
