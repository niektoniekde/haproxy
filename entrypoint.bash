#! /bin/bash
set -eux
CONFD="/usr/local/etc/haproxy/conf.d"

if ! [[ -n $(ls -1A ${CONFD}) ]]; then
  echo "ERROR: there are no configuration files to be included in directory: '${CONFD}' " >&2
  exit 100
fi

exec /usr/sbin/haproxy -W -db -f "/usr/local/etc/haproxy/haproxy.cfg" -f "${CONFD}"
