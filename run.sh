#!/bin/sh

main() {
  generate-configs \
    && supervisord -n
}

main
