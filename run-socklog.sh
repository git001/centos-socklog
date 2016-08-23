#!/bin/sh

set -x
exec /usr/local/bin/socklog inet 0 ${SYSLOG_PORT}
