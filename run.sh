#!/bin/sh

main() {
  generate-configs \
    && /bin/bash -c 'chown -R mongodb /opt/mongodb' \
    && supervisord -n
}

main
