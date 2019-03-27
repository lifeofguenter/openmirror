#!/usr/bin/env bash

test -x /usr/sbin/logrotate || exit 0
buf="$(/usr/sbin/logrotate /etc/logrotate.conf &> /dev/stdout)"
if [[ "${?}" -gt 0 ]]; then
  echo "${buf}" | mailx -s "${0}" -r '{{ admin_addr_from }}' '{{ admin_addr_to }}'
fi
