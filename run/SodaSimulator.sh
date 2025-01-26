#!/bin/sh
echo -ne '\033c\033]0;ggj2025\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/SodaSimulator.x86_64" "$@"
