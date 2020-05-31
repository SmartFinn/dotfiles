#!/usr/bin/env bash

set -euo pipefail

target_uri="$(gio info "$1" | awk '/standard::target-uri/ { print $2; }')"

setsid xdg-open "${target_uri:?Unable to get target URI}"
